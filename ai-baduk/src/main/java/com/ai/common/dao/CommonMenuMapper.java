package com.ai.common.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.common.vo.CommonMenuVo;

/**
 * @author 우동하
 * @since 2022. 11. 10
 * @implSpec menu database connection.
 */
@Mapper
public interface CommonMenuMapper {
	/**
	 * @implNote select top menu.
	 * @param roleId
	 * @return List<CommonMenuVo>
	 */
	public List<CommonMenuVo> selectTopMenu(String roleId);

}
