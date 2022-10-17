package com.ai.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.admin.vo.UserSearchVo;
import com.ai.admin.vo.UserVo;

/**
 * @author 우동하
 * @since 2022. 10. 17
 * @implSpec withdrawal database connection.
 */
@Mapper
public interface WithdrawalMapper {
	/**
	 * @implNote select withdrawal list.
	 * @param userSearchVo
	 * @return List<UserVo>
	 */
	public List<UserVo> selectWithdrawalList(UserSearchVo codeSearchVo);

	/**
	 * @implNote select withdrawal info.
	 * @param userVo
	 * @return UserVo
	 */
	public UserVo selectWithdrawalOne(UserVo userVo);

	/**
	 * @implNote update withdrawal.
	 * @param userVo
	 * @return
	 */
	public int updateWithdrawal(UserVo userVo);

}
