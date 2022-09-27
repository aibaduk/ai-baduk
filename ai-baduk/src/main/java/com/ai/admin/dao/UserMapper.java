package com.ai.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ai.admin.vo.UserSearchVo;
import com.ai.admin.vo.UserVo;

/**
 * @author 우동하
 * @since 2022. 09. 25
 * @implSpec user database connection.
 */
@Repository("UserMgmtMapper")
@Mapper
public interface UserMapper {
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

	/**
	 * @implNote update user.
	 * @param userVo
	 * @return
	 */
	public int updateUser(UserVo userVo);

	/**
	 * @implNote update password.
	 * @param userVo
	 * @return
	 */
	public int updatePassword(UserVo userVo);

}