package com.ai.auth.dao;

import org.apache.ibatis.annotations.Mapper;

import com.ai.auth.vo.UserVo;

@Mapper
public interface AuthMapper {
	// 로그인
    UserVo getUserAccount(String userId);

    // 회원가입 존재여부 체크
    String selectExistsUser(String userId);

    // 회원가입
    void saveUser(UserVo userVo);
}
