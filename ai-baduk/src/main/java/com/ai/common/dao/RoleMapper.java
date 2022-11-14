package com.ai.common.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @author 우동하
 * @since 2022. 11. 05
 * @implSpec role database connection.
 */
@Mapper
public interface RoleMapper {
	/**
	 * @implNote select menuId.
	 * @param forwordUrl
	 * @return
	 */
	public String selectMenuId(String forwordUrl);

	/**
	 * @implNote select permCnt.
	 * @param menuId, roleId
	 * @return
	 */
	public String selectPermCnt(@Param("menuId")String menuId, @Param("roleId")String roleId);

}
