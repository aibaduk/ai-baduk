package com.ai.admin.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.admin.service.CodeService;
import com.ai.admin.service.MenuService;
import com.ai.common.util.Constants;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 11. 05
 * @implSpec menu controller view.
 */
@Controller
@RequestMapping("/admin/menu")
@Slf4j
public class MenuController {

	@Autowired
	MenuService menuService;

	@Autowired
	CodeService codeService;

	/**
	 * @implNote menu main.
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String prodMain(Model model) {
		return "admin/menu/menuMain";
	}

	/**
	 * @implNote select menu list.
	 * @param prodVo
	 * @return
	 */
	@RequestMapping("/select-list")
	public String selectMenuList(Model model) {
		model.addAttribute("result", menuService.selectMenuList());
		log.debug("#######selectMenuList: {}");
		return Constants.JSON_VIEW;
	}

}
