package com.ai.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.admin.vo.MenuVo;

/**
 * @author 우동하
 * @since 2022. 10. 24
 * @implSpec menu database connection.
 */
@Mapper
public interface MenuMapper {
	/**
	 * @implNote select menu list.
	 * @param
	 * @return List<MenuVo>
	 */
	public List<MenuVo> selectMenuList();

	/**
	 * @implNote select menu tree.
	 * @param menuId
	 * @return List<MenuVo>
	 */
	public List<MenuVo> selectMenuTree(String menuId);

	/**
	 * @implNote select menuId.
	 * @param
	 * @return
	 */
	public String selectMenuId();

	/**
	 * @implNote insert menu.
	 * @param menuVo
	 * @return
	 */
	public int insertMenu(MenuVo menuVo);

	/**
	 * @implNote update menu.
	 * @param menuVo
	 * @return
	 */
	public int updateMenu(MenuVo menuVo);

	/**
	 * @implNote delete role menu.
	 * @param menuVo
	 * @return
	 */
	public int deleteRoleMenu(MenuVo menuVo);

	/**
	 * @implNote insert role menu.
	 * @param menuVo
	 * @return
	 */
	public int insertRoleMenu(MenuVo menuVo);

}
