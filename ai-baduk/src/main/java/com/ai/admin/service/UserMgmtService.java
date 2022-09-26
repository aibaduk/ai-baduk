package com.ai.admin.service;

import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ai.admin.dao.UserMgmtMapper;
import com.ai.admin.vo.UserSearchVo;
import com.ai.admin.vo.UserVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 09. 25
 * @implSpec user service business logic.
 */
@Service
public class UserMgmtService {

	@Autowired
	UserMgmtMapper userMapper;

	/**
	 * @implNote select user list.
	 * @param userSearchVo
	 * @return PageInfo<UserVo>
	 */
	public PageInfo<UserVo> selectUserList(UserSearchVo userSearchVo) {
		PageHelper.startPage(userSearchVo.getPageNo(), userSearchVo.getPageSize());

		PageInfo<UserVo> userList = new PageInfo<UserVo>(userMapper.selectUserList(userSearchVo), userSearchVo.getNavigatePages());
		int index = userSearchVo.getPageNo() * userSearchVo.getPageSize() - 10 + 1;
		IntStream.range(0, userList.getList().size())
		         .forEach(i -> {
		        	 userList.getList().get(i).setRowId(String.valueOf(index + i));
		         });

		return userList;
	}

	/**
	 * @implNote select user info.
	 * @param userVo
	 * @return UserVo
	 */
	public UserVo selectUserOne(UserVo userVo) {
		return userMapper.selectUserOne(userVo);
	}

}
