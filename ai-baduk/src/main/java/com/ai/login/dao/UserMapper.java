package com.ai.login.dao;

import org.apache.ibatis.annotations.Mapper;

import com.ai.login.vo.UserVo;

@Mapper
public interface UserMapper {
	// 로그인
    UserVo getUserAccount(String userId);

    // 회원가입
    void saveUser(UserVo userVo);
}
