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
import com.ai.admin.service.ProdService;
import com.ai.admin.vo.ProdSearchVo;
import com.ai.admin.vo.ProdVo;
import com.ai.common.util.Constants;
import com.ai.common.vo.FileVo;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 10. 24
 * @implSpec prod controller view.
 */
@Controller
@RequestMapping("/admin/prod")
@Slf4j
public class ProdController {

	@Autowired
	ProdService prodService;

	@Autowired
	CodeService codeService;

	/**
	 * @implNote prod main.
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String prodMain(Model model) {
		return "admin/prod/prodMain";
	}

	/**
	 * @implNote select prod list.
	 * @param prodVo
	 * @return
	 */
	@RequestMapping("/select-list")
	public String selectProdList(Model model, ProdSearchVo prodSearchVo) {
		final PageInfo<ProdVo> pageInfo = prodService.selectProdList(prodSearchVo);
		model.addAttribute("result", new PageResult<List<ProdVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
		log.debug("#######selectProdList: {}");
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote prod insert.
	 * @param model
	 * @return
	 */
	@GetMapping("/insert")
	public String prodInsert(Model model) {
		model.addAttribute("codeCU005", codeService.selectCode("CU005"));
		return "admin/prod/prodDetail";
	}

	/**
	 * @implNote page prod detail Linked and select prod info.
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/detail")
	public String prodDetail(Model model, ProdVo prodVo) {
		model.addAttribute("prodDetailInfo", prodService.selectProdOne(prodVo));
		model.addAttribute("codeCU005", codeService.selectCode("CU005"));
		return "admin/prod/prodDetail";
	}

	/**
	 * @implNote insert prod.
	 * @param prodVo
	 * @return
	 */
	@PostMapping("/insert")
	public String insertProd(Model model
			, ProdVo prodVo
			, @RequestParam(value="uploadFiles", required = false) List<MultipartFile> fileList) {
		try {
			model.addAttribute("prodVo", prodService.insertProd(prodVo, fileList));
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote update prod.
	 * @param prodVo
	 * @return
	 */
	@PostMapping("/update")
	public String updateProd(Model model
			, ProdVo prodVo
			, @RequestParam(value="uploadFiles", required = false) List<MultipartFile> fileList) {
		try {
			prodService.updateProd(prodVo, fileList);
			model.addAttribute("prodVo", prodVo);
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote delete prod file.
	 * @param prodVo
	 * @return
	 */
	@PostMapping("/fileDelete")
	public String deleteProdFile(Model model, @RequestBody FileVo fileVo) {
		try {
			String targetId = fileVo.getTargetId();
			prodService.deleteProdFile(fileVo);
			model.addAttribute("prodId", targetId);
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote download prod file.
	 * @param prodVo
	 * @return
	 * @throws IOException
	 */
	@GetMapping("/fileDownload")
	public ResponseEntity<Resource> prodFileDownload(Model model, FileVo fileVo) throws IOException {
		return prodService.prodFileDownload(fileVo);
	}
}
