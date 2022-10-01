package com.ai.common.web;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import com.ai.common.vo.BaseVo;
import com.ai.auth.vo.UserVo;

/**
 * @author 우동하
 * @since 2022. 09. 13
 * @implSpec common service.
 */
@Controller
public class CommonService {
	public static void setSessionData(final BaseVo baseVo) {
		Object object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		UserVo userVo = (object.equals("anonymousUser")) ? new UserVo() : (UserVo)object;
		baseVo.setSsLoginId(userVo.getSsLoginId());
	}
}
