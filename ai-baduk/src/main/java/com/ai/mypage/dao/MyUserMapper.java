package com.ai.mypage.dao;

import org.apache.ibatis.annotations.Mapper;

import com.ai.mypage.vo.MyUserVo;

/**
 * @author 우동하
 * @since 2022. 10. 02
 * @implSpec myPage > user database connection.
 */
@Mapper
public interface MyUserMapper {
	/**
	 * @implNote select user info.
	 * @param userId
	 * @return MyUserVo
	 */
	public MyUserVo selectUserOne(String userId);

	/**
	 * @implNote update user.
	 * @param myUserVo
	 * @return
	 */
	public int updateUser(MyUserVo myUserVo);

	/**
	 * @implNote update password.
	 * @param myUserVo
	 * @return
	 */
	public int updatePassword(MyUserVo myUserVo);

}
