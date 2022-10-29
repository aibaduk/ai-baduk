package com.ai.product.web;

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
import com.ai.product.service.PubProductService;
import com.ai.product.vo.PubProductSearchVo;
import com.ai.product.vo.PubProductVo;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 08. 05
 * @implSpec board controller view.
 */
@Controller
@RequestMapping("/product")
@Slf4j
public class PubProductController {

	@Autowired
	PubProductService pubProductService;

	@Autowired
	CodeService codeService;

	/**
	 * @implNote product main.
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String productMain(Model model) {
		return "product/pubProductMain";
	}

	/**
	 * @implNote select product list.
	 * @param productVo
	 * @return
	 */
	@RequestMapping("/select-list")
	public String selectProductList(Model model, PubProductSearchVo pubProductSearchVo) {
		final PageInfo<PubProductVo> pageInfo = pubProductService.selectProductList(pubProductSearchVo);
		model.addAttribute("result", new PageResult<List<PubProductVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
		log.debug("#######selectProductList: {}");
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote page product detail Linked and select product info.
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/detail")
	public String productDetail(Model model, PubProductVo pubProductVo) {
		model.addAttribute("productDetailInfo", pubProductService.selectProductOne(pubProductVo));
		model.addAttribute("codeCU005", codeService.selectCode("CU005"));
		return "product/pubProductDetail";
	}
}
