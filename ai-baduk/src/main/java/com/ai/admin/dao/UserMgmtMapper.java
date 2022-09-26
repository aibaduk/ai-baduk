package com.ai.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.admin.vo.UserSearchVo;
import com.ai.admin.vo.UserVo;

/**
 * @author 우동하
 * @since 2022. 09. 25
 * @implSpec user database connection.
 */
@Mapper
public interface UserMgmtMapper {
	/**
	 * @implNote select user list.
	 * @param userSearchVo
	 * @return List<UserVo>
	 */
	public List<UserVo> selectUserList(UserSearchVo codeSearchVo);

	/**
	 * @implNote select user info.
	 * @param userVo
	 * @return UserVo
	 */
	public UserVo selectUserOne(UserVo userVo);

}