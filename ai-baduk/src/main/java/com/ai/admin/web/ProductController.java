package com.ai.admin.web;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ai.admin.service.CodeService;
import com.ai.admin.service.ProductService;
import com.ai.admin.vo.ProductSearchVo;
import com.ai.admin.vo.ProductVo;
import com.ai.common.util.Constants;
import com.ai.common.vo.FileVo;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 10. 24
 * @implSpec product controller view.
 */
@Controller
@RequestMapping("/admin/product")
@Slf4j
public class ProductController {

	@Autowired
	ProductService productService;

	@Autowired
	CodeService codeService;

	/**
	 * @implNote product main.
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String productMain(Model model) {
		return "admin/product/productMain";
	}

	/**
	 * @implNote select product list.
	 * @param productVo
	 * @return
	 */
	@RequestMapping("/select-list")
	public String selectProductList(Model model, ProductSearchVo productSearchVo) {
		final PageInfo<ProductVo> pageInfo = productService.selectProductList(productSearchVo);
		model.addAttribute("result", new PageResult<List<ProductVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
		log.debug("#######selectProductList: {}");
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote product insert.
	 * @param model
	 * @return
	 */
	@GetMapping("/insert")
	public String productInsert(Model model) {
		model.addAttribute("codeCU005", codeService.selectCode("CU005"));
		return "admin/product/productDetail";
	}

	/**
	 * @implNote page product detail Linked and select product info.
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/detail")
	public String productDetail(Model model, ProductVo productVo) {
		model.addAttribute("productDetailInfo", productService.selectProductOne(productVo));
		model.addAttribute("codeCU005", codeService.selectCode("CU005"));
		return "admin/product/productDetail";
	}

	/**
	 * @implNote insert product.
	 * @param productVo
	 * @return
	 */
	@PostMapping("/insert")
	public String insertProduct(Model model
			, ProductVo productVo
			, @RequestParam(value="uploadFiles", required = false) List<MultipartFile> fileList) {
		try {
			model.addAttribute("productVo", productService.insertProduct(productVo, fileList));
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote update product.
	 * @param productVo
	 * @return
	 */
	@PostMapping("/update")
	public String updateProduct(Model model
			, ProductVo productVo
			, @RequestParam(value="uploadFiles", required = false) List<MultipartFile> fileList) {
		try {
			productService.updateProduct(productVo, fileList);
			model.addAttribute("productVo", productVo);
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote delete product file.
	 * @param productVo
	 * @return
	 */
	@PostMapping("/fileDelete")
	public String deleteProductFile(Model model, @RequestBody FileVo fileVo) {
		try {
			productService.deleteProductFile(fileVo);
			model.addAttribute("productId", fileVo.getTargetId());
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote download product file.
	 * @param productVo
	 * @return
	 * @throws IOException
	 */
	@GetMapping("/fileDownload")
	public ResponseEntity<Resource> productFileDownload(Model model, FileVo fileVo) throws IOException {
		return productService.productFileDownload(fileVo);
	}
}
