package com.ai.admin.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.admin.service.CodeService;
import com.ai.admin.service.DownService;
import com.ai.admin.vo.ProdDownSearchVo;
import com.ai.admin.vo.ProdDownVo;
import com.ai.common.exception.BizException;
import com.ai.common.util.Constants;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 11. 02
 * @implSpec down controller view.
 */
@Controller
@RequestMapping("/admin/down")
@Slf4j
public class DownController {

	@Autowired
	DownService downService;

	@Autowired
	CodeService codeService;

	/**
	 * @implNote down main.
	 * @param model
	 * @return
	 */
	@GetMapping("/prod/main")
	public String prodDownMain(Model model) {
		return "admin/down/prodDownMain";
	}

	/**
	 * @implNote select down list.
	 * @param prodDownSearchVo
	 * @return
	 */
	@RequestMapping("/prod/select-list")
	public String selectProdDownList(Model model, ProdDownSearchVo prodDownSearchVo) {
		final PageInfo<ProdDownVo> pageInfo = downService.selectProdDownList(prodDownSearchVo);
		model.addAttribute("result", new PageResult<List<ProdDownVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
		log.debug("#######selectProdDownList: {}");
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote update down status.
	 * @param downList
	 * @return
	 */
	@PostMapping("/prod/update-down-status")
	public String updateProdDownStatus(Model model, @RequestBody List<ProdDownVo> downList) {
		try {
			downService.updateProdDownStatus(downList);
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

}
