package com.ai.admin.service;

import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ai.admin.dao.WithdrawalMapper;
import com.ai.admin.vo.UserSearchVo;
import com.ai.admin.vo.UserVo;
import com.ai.common.web.CommonService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 10. 17
 * @implSpec withdrawal service business logic.
 */
@Service
public class WithdrawalService {

	@Autowired
	WithdrawalMapper withdrawalMapper;

	/**
	 * @implNote select withdrawal list.
	 * @param userSearchVo
	 * @return PageInfo<UserVo>
	 */
	public PageInfo<UserVo> selectWithdrawalList(UserSearchVo userSearchVo) {
		PageHelper.startPage(userSearchVo.getPageNo(), userSearchVo.getPageSize());

		PageInfo<UserVo> userList = new PageInfo<UserVo>(withdrawalMapper.selectWithdrawalList(userSearchVo), userSearchVo.getNavigatePages());
		int index = userSearchVo.getPageNo() * userSearchVo.getPageSize() - 10 + 1;
		IntStream.range(0, userList.getList().size())
		         .forEach(i -> {
		        	 userList.getList().get(i).setRowId(String.valueOf(index + i));
		         });

		return userList;
	}

	/**
	 * @implNote select withdrawal info.
	 * @param userVo
	 * @return UserVo
	 */
	public UserVo selectWithdrawalOne(UserVo userVo) {
		return withdrawalMapper.selectWithdrawalOne(userVo);
	}

	/**
	 * @implNote update withdrawal.
	 * @param userVo
	 * @return
	 */
	@Transactional
	public void updateWithdrawal(UserVo userVo) {
		CommonService.setSessionData(userVo);
		withdrawalMapper.updateWithdrawal(userVo);
	}

}
