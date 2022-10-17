package com.ai.admin.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.admin.service.CodeService;
import com.ai.admin.service.WithdrawalService;
import com.ai.admin.vo.UserSearchVo;
import com.ai.admin.vo.UserVo;
import com.ai.common.exception.BizException;
import com.ai.common.util.Constants;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 10. 17
 * @implSpec withdrawal controller view.
 */
@Controller
@RequestMapping("/admin/withdrawal")
@Slf4j
public class WithdrawalController {

	@Autowired
	WithdrawalService withdrawalService;

	@Autowired
	CodeService codeService;

	/**
	 * @implNote user main.
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String userMain(Model model) {
		return "admin/withdrawal/withdrawalMain";
	}

	/**
	 * @implNote select user list.
	 * @param userVo
	 * @return
	 */
	@RequestMapping("/select-list")
	public String selectWithdrawalList(Model model, UserSearchVo userSearchVo) {
		final PageInfo<UserVo> pageInfo = withdrawalService.selectWithdrawalList(userSearchVo);
		model.addAttribute("result", new PageResult<List<UserVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
		log.debug("#######selectWithdrawalList: {}");
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote page withdrawal detail Linked and select withdrawal info.
	 * @param userVo
	 * @return
	 */
	@GetMapping("/detail")
	public String withdrawalDetail(Model model, UserVo userVo) {
		model.addAttribute("codeCU001", codeService.selectCode("CU001"));
    	model.addAttribute("codeCU002", codeService.selectCode("CU002"));
    	model.addAttribute("codeCU003", codeService.selectCode("CU003"));
    	model.addAttribute("codeCU004", codeService.selectCode("CU004"));
    	model.addAttribute("withdrawalDetailInfo", withdrawalService.selectWithdrawalOne(userVo));
		return "admin/withdrawal/withdrawalDetail";
	}

	/**
	 * @implNote update withdrawal.
	 * @param userVo
	 * @return
	 */
	@PostMapping("/update")
	public String updateWithdrawal(Model model, UserVo userVo) {
		try {
			withdrawalService.updateWithdrawal(userVo);
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

}
