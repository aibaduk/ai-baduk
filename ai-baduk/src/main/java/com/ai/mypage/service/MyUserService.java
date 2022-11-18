package com.ai.mypage.service;

import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ai.common.exception.BizException;
import com.ai.common.util.MessageUtils;
import com.ai.common.web.CommonService;
import com.ai.mypage.dao.MyUserMapper;
import com.ai.mypage.vo.MyUserVo;

/**
 * @author 우동하
 * @since 2022. 10. 02
 * @implSpec myPage > user service business logic.
 */
@Service
public class MyUserService {

	@Autowired
	MyUserMapper myUserMapper;

	@Autowired
	PasswordEncoder passwordEncoder;

	/**
	 * @implNote select user info.
	 * @param myUserVo
	 * @return MyUserVo
	 */
	public MyUserVo selectUserOne(String userId) {
		return myUserMapper.selectUserOne(userId);
	}

	/**
	 * @implNote update user.
	 * @param myUserVo
	 * @return
	 */
	@Transactional
	public void updateUser(MyUserVo myUserVo) {
		CommonService.setSessionData(myUserVo);
		myUserMapper.updateUser(myUserVo);
	}

	/**
	 * @implNote update password.
	 * @param myUserVo
	 * @return
	 */
	@Transactional
	public void updatePassword(MyUserVo myUserVo) {
		final MyUserVo persistUser = myUserMapper.selectUserOne(myUserVo.getUserId());
		if (Objects.isNull(persistUser)) {
			throw new BizException(MessageUtils.getMessage("ERROR.USER.001"));
		}
		if(!passwordEncoder.matches(myUserVo.getOldPW(), persistUser.getUserPw())) {
			throw new BizException(MessageUtils.getMessage("ERROR.USER.002"));
		}
		if(myUserVo.getOldPW().equals(myUserVo.getNewPW())) {
			throw new BizException(MessageUtils.getMessage("ERROR.USER.003"));
		}
		if(!myUserVo.getNewPW().equals(myUserVo.getNewPWcheck())) {
			throw new BizException(MessageUtils.getMessage("ERROR.USER.004"));
		}
		CommonService.setSessionData(myUserVo);
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		myUserVo.setUserPw(passwordEncoder.encode(myUserVo.getNewPW()));
		myUserMapper.updatePassword(myUserVo);
	}

}
