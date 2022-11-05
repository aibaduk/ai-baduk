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

}
