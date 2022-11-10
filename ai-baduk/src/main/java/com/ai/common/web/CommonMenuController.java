package com.ai.common.web;

import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.auth.vo.UserVo;
import com.ai.common.exception.BizException;
import com.ai.common.service.CommonMenuService;
import com.ai.common.util.Constants;

/**
 * @author 우동하
 * @since 2022. 11. 10
 * @implSpec common service.
 */
@Controller
@RequestMapping("/common/menu")
public class CommonMenuController {

	@Autowired
	CommonMenuService commonMenuService;

	/**
	 * @implNote select top menu.
	 * @param roleId
	 * @return List<CommonMenuVo>
	 */
	@RequestMapping("/header")
	public String selectTopMenu(Model model, Authentication authentication) {
		try {
			String roleId = "";
			if (!Objects.isNull(authentication)) {
	    		UserVo userVo = (UserVo) authentication.getPrincipal();
	    		roleId = userVo.getUserAuth();
	    	}
			model.addAttribute("menuList", commonMenuService.selectTopMenu(roleId));
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
		}


		return Constants.JSON_VIEW;
	}
}
