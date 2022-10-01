package com.ai.admin.service;

import java.util.Objects;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ai.admin.dao.UserMapper;
import com.ai.admin.vo.UserSearchVo;
import com.ai.admin.vo.UserVo;
import com.ai.common.exception.BizException;
import com.ai.common.web.CommonService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 09. 25
 * @implSpec user service business logic.
 */
@Service
public class UserService {

	@Autowired
	UserMapper userMapper;

	@Autowired
	PasswordEncoder passwordEncoder;

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

	/**
	 * @implNote update user.
	 * @param userVo
	 * @return
	 */
	@Transactional
	public void updateUser(UserVo userVo) {
		CommonService.setSessionData(userVo);
		userMapper.updateUser(userVo);
	}

	/**
	 * @implNote update password.
	 * @param userVo
	 * @return
	 */
	@Transactional
	public void updatePassword(UserVo userVo) {
		final UserVo persistUser = userMapper.selectUserOne(userVo);
		if (Objects.isNull(persistUser)) {
			throw new BizException("회원정보를 찾을 수 없습니다.");
		}
		if(!userVo.getNewPW().equals(userVo.getNewPWcheck())) {
			throw new BizException("신규 비밀번호가 일치하지 않습니다.");
		}
		if(userVo.getOldPW().equals(userVo.getNewPW())) {
			throw new BizException("기존 비밀번호와 신규 비밀번호가 일치합니다.\n다른 비밀번호를 입력하세요.");
		}
		if(!passwordEncoder.matches(userVo.getOldPW(), persistUser.getUserPw())) {
			throw new BizException("기존 비밀번호가 일치하지 않습니다.");
		}
		CommonService.setSessionData(userVo);
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        userVo.setUserPw(passwordEncoder.encode(userVo.getNewPW()));
		userMapper.updatePassword(userVo);
	}

}
