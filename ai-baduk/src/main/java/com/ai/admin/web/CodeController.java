package com.ai.admin.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ai.admin.service.CodeService;
import com.ai.admin.vo.CodeSearchVo;
import com.ai.admin.vo.CodeVo;
import com.ai.common.util.Constants;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 08. 22
 * @implSpec code controller view.
 */
@Controller
@RequestMapping("/admin/code")
@Slf4j
public class CodeController {

	@Autowired
	CodeService codeService;

	/**
	 * @implNote code main.
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String codeMain(Model model) {
		return "admin/code/codeMain";
	}

	/**
	 * @implNote select code list.
	 * @param codeVo
	 * @return
	 */
	@RequestMapping("/select-list")
	public String selectCodeList(Model model, CodeSearchVo codeSearchVo) {
		final PageInfo<CodeVo> pageInfo = codeService.selectCodeList(codeSearchVo);
		model.addAttribute("result", new PageResult<List<CodeVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
		log.debug("#######selectCodeList: {}");
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote code insert.
	 * @param model
	 * @return
	 */
	@GetMapping("/insert")
	public String codeInsert(Model model) {
		return "admin/code/codeDetail";
	}

	/**
	 * @implNote page code detail Linked and select code info.
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/detail")
	public String codeDetail(Model model, @RequestParam("lCd") String lCd) {
		List<CodeVo> codeList = codeService.selectCodeByLCd(lCd);
		CodeVo upCodeVo = null;
		for (CodeVo codeVo : codeList) {
			if ("*".equals(codeVo.getCodeId())) {
				upCodeVo =  codeVo;
			}
			break;
		}
		model.addAttribute("upCodeVo", upCodeVo);
		model.addAttribute("codeList", codeList);
		return "admin/code/codeDetail";
	}

	/**
	 * @implNote insert code.
	 * @param codeList
	 * @return
	 */
	@PostMapping("/insert")
	public String insertCode(Model model, List<CodeVo> codeList) {
		try {
			model.addAttribute("codeId", codeService.insertCode(codeList));
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}
}
