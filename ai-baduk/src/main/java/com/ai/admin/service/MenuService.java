package com.ai.admin.service;

import java.util.List;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ai.admin.dao.MenuMapper;
import com.ai.admin.vo.MenuVo;
import com.ai.common.web.CommonService;

/**
 * @author 우동하
 * @since 2022. 11. 05
 * @implSpec menu service business logic.
 */
@Service
public class MenuService {

	@Autowired
	MenuMapper menuMapper;

	/**
	 * @implNote select menu list.
	 * @param
	 * @return List<MenuVo>
	 */
	public List<MenuVo> selectMenuList() {
		return menuMapper.selectMenuList();
	}

	/**
	 * @implNote select menu tree.
	 * @param menuId
	 * @return List<MenuVo>
	 */
	public List<MenuVo> selectMenuTree(String menuId) {
		return menuMapper.selectMenuTree(menuId);
	}

	/**
	 * @implNote insert menu.
	 * @param menuVo
	 * @return
	 */
	@Transactional
	public String insertMenu(MenuVo menuVo) {
		// 1. menuId 채번.
		String menuId = menuMapper.selectMenuId();

		// 2. 메뉴 테이블 저장
		CommonService.setSessionData(menuVo);
		menuVo.setMenuId(menuId);
		menuMapper.insertMenu(menuVo);

		// 3. 메뉴 룰 테이블 저장
		List<String> roleList = menuVo.getRoleList();
		if (!Objects.isNull(roleList) && !roleList.isEmpty()) {
			roleList.forEach(role -> {
				menuVo.setRoleId(role);
				menuMapper.insertRoleMenu(menuVo);
			});
		}
		return menuId;
	}

	/**
	 * @implNote update menu.
	 * @param menuVo
	 * @return
	 */
	@Transactional
	public void updateMenu(MenuVo menuVo) {
		CommonService.setSessionData(menuVo);
		// 1. 메뉴 테이블 저장
		menuMapper.updateMenu(menuVo);

		// 2. 메뉴 룰 테이블 삭제
		menuMapper.deleteRoleMenu(menuVo);

		// 3. 메뉴 룰 테이블 저장
		List<String> roleList = menuVo.getRoleList();
		if (!Objects.isNull(roleList) && !roleList.isEmpty()) {
			roleList.forEach(role -> {
				menuVo.setRoleId(role);
				menuMapper.insertRoleMenu(menuVo);
			});
		}
	}

}
