package com.ai.prod.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.admin.service.CodeService;
import com.ai.common.util.Constants;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
import com.ai.prod.service.PubProdService;
import com.ai.prod.vo.PubProdSearchVo;
import com.ai.prod.vo.PubProdVo;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 10. 24
 * @implSpec prod controller view.
 */
@Controller
@RequestMapping("/prod")
@Slf4j
public class PubProdController {

	@Autowired
	PubProdService pubProdService;

	@Autowired
	CodeService codeService;

	/**
	 * @implNote prod main.
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String prodMain(Model model) {
		return "prod/pubProdMain";
	}

	/**
	 * @implNote select prod list.
	 * @param prodVo
	 * @return
	 */
	@RequestMapping("/select-list")
	public String selectProdList(Model model, PubProdSearchVo pubProdSearchVo) {
		final PageInfo<PubProdVo> pageInfo = pubProdService.selectProdList(pubProdSearchVo);
		model.addAttribute("result", new PageResult<List<PubProdVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
		log.debug("#######selectProdList: {}");
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote page prod detail Linked and select prod info.
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/detail")
	public String prodDetail(Model model, PubProdVo pubProdVo) {
		model.addAttribute("prodDetailInfo", pubProdService.selectProdOne(pubProdVo));
		model.addAttribute("codeCU005", codeService.selectCode("CU005"));
		return "prod/pubProdDetail";
	}
}
