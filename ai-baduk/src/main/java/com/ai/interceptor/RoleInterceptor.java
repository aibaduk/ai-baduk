package com.ai.interceptor;

import java.util.Objects;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;

import com.ai.auth.vo.UserVo;
import com.ai.common.web.RoleService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class RoleInterceptor implements HandlerInterceptor {

	@Autowired
	RoleService roleService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();
		String forwordUrl = request.getServletPath();
		String filterUrl = "";
		String forwordUrl2 = "";
		String forwordUrl3 = "";
		String menuId = "";
		String permCnt = "";
		String checkVal = "Y";

		int filterLastIndex = forwordUrl.lastIndexOf("/");
		if (filterLastIndex > 0) {
			filterUrl = forwordUrl.substring(0, filterLastIndex);
			forwordUrl2 = forwordUrl.substring(0, filterLastIndex);
			forwordUrl3 = forwordUrl2.substring(0, forwordUrl2.lastIndexOf("/"));
			forwordUrl2 = forwordUrl2 + "/*";
			forwordUrl3 = forwordUrl3 + "/*/*";
		} else {
			filterUrl = forwordUrl;
			forwordUrl2 = forwordUrl;
			forwordUrl3 = forwordUrl;
		}

		String[] filterStrs = {
			"/", "/static/images", "/static/js", "/static/css"
		};

		for (int i=0; i<filterStrs.length; i++) {
			if (forwordUrl.equals(filterStrs[i]) || filterUrl.equals(filterStrs[i])) {
				checkVal = "N";
				break;
			}
		}

		if (isAjaxRequest(request) || "Y".equals(checkVal)) {

			session.removeAttribute("ssMenuId");
			session.removeAttribute("ssPermCnt");

			menuId = roleService.selectMenuId(forwordUrl);

			if (Objects.isNull(menuId)) {
				menuId = roleService.selectMenuId(forwordUrl2);
			}
			if (Objects.isNull(menuId)) {
				menuId = roleService.selectMenuId(forwordUrl3);
			}
			if (!Objects.isNull(menuId)) {
				Object object = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				UserVo userVo = (object.equals("anonymousUser")) ? new UserVo() : (UserVo)object;
				String roleId = userVo.getSsRoleId();
				permCnt = roleService.selectPermCnt(menuId, roleId);
			}
			session.setAttribute("ssMenuId", menuId);
			session.setAttribute("ssPermCnt", permCnt);
		}

		return true;
	}

	private boolean isAjaxRequest(HttpServletRequest request) {
		String header = request.getHeader("x-requested-with");
		log.debug("isAjaxRequest.header: {}", header);
		if ("XMLHttpRequest".equals(header)) {
			return true;
		}
		return false;
	}

}
