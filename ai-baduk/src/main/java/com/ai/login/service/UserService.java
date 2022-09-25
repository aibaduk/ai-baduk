package com.ai.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ai.common.exception.BizException;
import com.ai.login.dao.UserMapper;
import com.ai.login.vo.UserVo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserService implements UserDetailsService{

	@Autowired
    private final UserMapper userMapper;

    @Transactional
    public void joinUser(UserVo userVo) {
    	if("Y".equals(userMapper.selectExistsUser(userVo.getUserId()))) {
    		throw new BizException("동일한 ID로 가입된 회원이 존재합니다.");
    	}
    	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        userVo.setUserPw(passwordEncoder.encode(userVo.getPassword()));
        userVo.setSsLoginId("ADMIN");
        userMapper.saveUser(userVo);
    }

    @Override
    public UserVo loadUserByUsername(String userId) throws UsernameNotFoundException {
        //여기서 받은 유저 패스워드와 비교하여 로그인 인증
        UserVo userVo = userMapper.getUserAccount(userId);
        if (userVo == null){
            throw new UsernameNotFoundException("User not authorized.");
        }
        return userVo;
    }
}
