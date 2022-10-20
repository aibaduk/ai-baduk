package com.ai.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.admin.vo.UserSearchVo;
import com.ai.admin.vo.UserVo;
import com.ai.mypage.vo.MyAnalyzeInfoVo;

/**
 * @author 우동하
 * @since 2022. 09. 25
 * @implSpec user database connection.
 */
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

	/**
	 * @implNote delete user.
	 * @param userId
	 * @return
	 */
	public int withdrawal(String userId);

	/**
	 * @implNote select analyze info.
	 * @param analyzeInfoVo
	 * @return AnalyzeInfoVo
	 */
	public List<MyAnalyzeInfoVo> selectAnalyzeInfoList(MyAnalyzeInfoVo analyzeInfoVo);

	/**
	 * @implNote save analyzeInfo.
	 * @param analyzeInfoVo
	 * @return
	 */
	public int mergeAnalyzeInfo(MyAnalyzeInfoVo analyzeInfoVo);

}
