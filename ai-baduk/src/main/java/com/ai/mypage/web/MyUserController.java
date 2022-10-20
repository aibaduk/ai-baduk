package com.ai.mypage.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.admin.service.CodeService;
import com.ai.auth.vo.UserVo;
import com.ai.common.exception.BizException;
import com.ai.common.util.Constants;
import com.ai.mypage.service.MyUserService;
import com.ai.mypage.vo.MyUserVo;

/**
 * @author 우동하
 * @since 2022. 10. 02
 * @implSpec 회원정보 controller view.
 */
@Controller
@RequestMapping("/mypage/user")
public class MyUserController {

	@Autowired
	MyUserService myUserService;

	@Autowired
	CodeService codeService;

	/**
	 * @implNote page user detail Linked and select user info.
	 * @param myUserVo
	 * @return
	 */
	@GetMapping("/detail")
	public String userDetail(Model model, Authentication authentication) {
		UserVo userVo = (UserVo) authentication.getPrincipal();
		model.addAttribute("codeCU001", codeService.selectCode("CU001"));
    	model.addAttribute("codeCU002", codeService.selectCode("CU002"));
    	model.addAttribute("codeCU003", codeService.selectCode("CU003"));
    	model.addAttribute("codeCU004", codeService.selectCode("CU004"));
    	model.addAttribute("userDetailInfo", myUserService.selectUserOne(userVo.getUserId()));
    	return "mypage/myuser/myUserDetail";
	}

	/**
	 * @implNote update user.
	 * @param myUserVo
	 * @return
	 */
	@PostMapping("/update")
	public String updateUser(Model model, MyUserVo myUserVo) {
		try {
			myUserService.updateUser(myUserVo);
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
			model.addAttribute("code", e.getErrCode());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote update password.
	 * @param myUserVo
	 * @return
	 */
	@PostMapping("/update-password")
	public String updatePassword(Model model, MyUserVo myUserVo) {
		try {
			myUserService.updatePassword(myUserVo);
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
			model.addAttribute("code", e.getErrCode());
		}
		return Constants.JSON_VIEW;
	}

}
