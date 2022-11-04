package com.ai.down.web;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.admin.service.CodeService;
import com.ai.auth.vo.UserVo;
import com.ai.common.exception.BizException;
import com.ai.common.util.Constants;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
import com.ai.down.service.PubDownService;
import com.ai.down.vo.PubProdDownSearchVo;
import com.ai.down.vo.PubProdDownVo;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 11. 01
 * @implSpec down controller view.
 */
@Controller
@RequestMapping("/down")
@Slf4j
public class PubDownController {

	@Autowired
	PubDownService downService;

	@Autowired
	CodeService codeService;

	/**
	 * @implNote down main.
	 * @param model
	 * @return
	 */
	@GetMapping("/prod/main")
	public String prodDownMain(Model model) {
		return "down/pubProdDownMain";
	}

	/**
	 * @implNote select down list.
	 * @param prodVo
	 * @return
	 */
	@RequestMapping("/prod/select-list")
	public String selectProdDownList(Model model, Authentication authentication, PubProdDownSearchVo downSearchVo) {
		UserVo userVo = (UserVo) authentication.getPrincipal();
		downSearchVo.setSearchUserId(userVo.getUserId());
		final PageInfo<PubProdDownVo> pageInfo = downService.selectProdDownList(downSearchVo);
		model.addAttribute("result", new PageResult<List<PubProdDownVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
		log.debug("#######selectDownList: {}");
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote insert down.
	 * @param userVo
	 * @return
	 */
	@PostMapping("/prod/insert")
	public String insertProdDown(Model model, PubProdDownVo downVo) {
		try {
			downService.insertProdDown(downVo);
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote update down status.
	 * @param userVo
	 * @return
	 */
	@PostMapping("/prod/update-down-status")
	public String updateProdDownStatus04(Model model, @RequestBody List<PubProdDownVo> downList) {
		try {
			downService.updateProdDownStatus04(downList);
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote down prod down zipFile.
	 * @param response
	 * @param downVo
	 * @return
	 */
	@GetMapping("/prod/zipFileDownload")
	public void zipFileDownload(Model model, Authentication authentication, HttpServletResponse response, PubProdDownVo downVo) {
		UserVo userVo = (UserVo) authentication.getPrincipal();
		downVo.setUserId(userVo.getUserId());
		String zipFileName = "ai_content.zip";
		downService.zipFileDownload(zipFileName, response, downVo);
	}

}
