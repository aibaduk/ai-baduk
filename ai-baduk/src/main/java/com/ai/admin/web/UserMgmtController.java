package com.ai.admin.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.admin.service.CodeService;
import com.ai.admin.service.UserMgmtService;
import com.ai.admin.vo.UserSearchVo;
import com.ai.admin.vo.UserVo;
import com.ai.common.util.Constants;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
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
public class UserMgmtController {

	@Autowired
	UserMgmtService userService;

	@Autowired
	CodeService codeService;

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
}