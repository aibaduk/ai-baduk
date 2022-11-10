package com.ai.admin.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.admin.service.CodeService;
import com.ai.admin.service.MenuService;
import com.ai.admin.vo.MenuVo;
import com.ai.common.exception.BizException;
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
    	model.addAttribute("codeCU004", codeService.selectCode("CU004"));
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

	/**
	 * @implNote select menu list.
	 * @param prodVo
	 * @return
	 */
	@RequestMapping("/select-tree/{id}")
	public String selectMenuTree(Model model, @PathVariable("id") String menuId) {
		model.addAttribute("result", menuService.selectMenuTree(menuId));
		log.debug("#######selectMenuTree.menuId: {}", menuId);
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote insert menu.
	 * @param menuVo
	 * @return
	 */
	@PostMapping("/insert")
	public String insertMenu(Model model, MenuVo menuVo) {
		try {
			model.addAttribute("menuId", menuService.insertMenu(menuVo));
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote update menu.
	 * @param menuVo
	 * @return
	 */
	@PostMapping("/update")
	public String updateMenu(Model model, MenuVo menuVo) {
		try {
			menuService.updateMenu(menuVo);
			model.addAttribute("menuId", menuVo.getMenuId());
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

}
