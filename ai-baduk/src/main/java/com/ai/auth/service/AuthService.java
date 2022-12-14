package com.ai.auth.service;

import java.util.Arrays;
import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ai.auth.dao.AuthMapper;
import com.ai.auth.vo.UserVo;
import com.ai.common.exception.BizException;
import com.ai.common.util.MessageUtils;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AuthService implements UserDetailsService{

	@Autowired
    private final AuthMapper authMapper;

	@Transactional
    public void adminJoinUser(UserVo userVo) {
    	if (selectExistsUser(userVo.getUserId())) {
    		throw new BizException(MessageUtils.getMessage("ERROR.AUTH.001"));
    	}
    	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        userVo.setUserPw(passwordEncoder.encode(userVo.getPassword()));
        userVo.setSsLoginId("ADMIN");
        authMapper.saveUser(userVo);
    }

    @Transactional
    public void joinUser(UserVo userVo) {
    	if (selectExistsUser(userVo.getUserId())) {
    		throw new BizException(MessageUtils.getMessage("ERROR.AUTH.001"));
    	}
    	BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        userVo.setUserPw(passwordEncoder.encode(userVo.getPassword()));
        userVo.setUserAuth("ROLE_USER");
        userVo.setSsLoginId("anonymous");
        authMapper.saveUser(userVo);
    }

    @Override
    public UserVo loadUserByUsername(String userId) throws UsernameNotFoundException {
        //여기서 받은 유저 패스워드와 비교하여 로그인 인증
        UserVo userVo = authMapper.getUserAccount(userId);
        if (Objects.isNull(userVo)){
        	throw new UsernameNotFoundException("User not authorized.");
        }
        userVo.setAuthorities(Arrays.asList(new SimpleGrantedAuthority(userVo.getUserAuth())));
        return userVo;
    }

    public boolean selectExistsUser(String userId) {
    	return ("Y".equals(authMapper.selectExistsUser(userId)));
    }
}
