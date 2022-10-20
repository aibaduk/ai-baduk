package com.ai.admin.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.admin.service.CodeService;
import com.ai.admin.service.UserService;
import com.ai.admin.vo.UserSearchVo;
import com.ai.admin.vo.UserVo;
import com.ai.common.exception.BizException;
import com.ai.common.util.Constants;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
import com.ai.common.web.ExcelService;
import com.ai.mypage.service.MyAnalyzeInfoService;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 09. 25
 * @implSpec user controller view.
 */
@Controller
@RequestMapping("/admin/user")
@Slf4j
public class UserController {

	@Autowired
	UserService userService;

	@Autowired
	CodeService codeService;

	@Autowired
	ExcelService excelService;

	@Autowired
	MyAnalyzeInfoService analyzeInfoService;

	/**
	 * @implNote user main.
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String userMain(Model model) {
		return "admin/user/userMain";
	}

	/**
	 * @implNote select user list.
	 * @param userVo
	 * @return
	 */
	@RequestMapping("/select-list")
	public String selectUserList(Model model, UserSearchVo userSearchVo) {
		final PageInfo<UserVo> pageInfo = userService.selectUserList(userSearchVo);
		model.addAttribute("result", new PageResult<List<UserVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
		log.debug("#######selectUserList: {}");
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote page user detail Linked and select user info.
	 * @param userVo
	 * @return
	 */
	@GetMapping("/detail")
	public String userDetail(Model model, UserVo userVo) {
		model.addAttribute("codeCU001", codeService.selectCode("CU001"));
    	model.addAttribute("codeCU002", codeService.selectCode("CU002"));
    	model.addAttribute("codeCU003", codeService.selectCode("CU003"));
    	model.addAttribute("codeCU004", codeService.selectCode("CU004"));
    	model.addAttribute("userDetailInfo", userService.selectUserOne(userVo));
		return "admin/user/userDetail";
	}

	/**
	 * @implNote update user.
	 * @param userVo
	 * @return
	 */
	@PostMapping("/update")
	public String updateUser(Model model, UserVo userVo) {
		try {
			userService.updateUser(userVo);
			model.addAttribute("userId", userVo.getUserId());
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
			model.addAttribute("code", e.getErrCode());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote update password.
	 * @param userVo
	 * @return
	 */
	@PostMapping("/update-password")
	public String updatePassword(Model model, UserVo userVo) {
		try {
			userService.updatePassword(userVo);
			model.addAttribute("userId", userVo.getUserId());
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
			model.addAttribute("code", e.getErrCode());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote delete user.
	 * @param userVo
	 * @return
	 */
	@PostMapping("/withdrawal")
	public String withdrawal(Model model, String userId) {
		try {
			userService.withdrawal(userId);
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

}
