package com.ai.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ai.admin.dao.MenuMapper;
import com.ai.admin.vo.MenuVo;

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

}
