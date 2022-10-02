package com.ai.mypage.vo;

import com.ai.common.vo.BaseVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class MyUserVo extends BaseVo {

	/** 회원ID */
	private String userId;

	/** 회원명 */
    private String userNm;

    /** 성별(CU001) */
    private String userSex;

    /** 성별(CU001) */
    private String userSexNm;

    /** 비밀번호 */
    private String userPw;

    /** 회원등급(CU002) */
    private String userGrade;

    /** 회원등급(CU002) */
    private String userGradeNm;

    /** 휴대폰번호1 */
    private String phoneNum1;

    /** 휴대폰번호2 */
    private String phoneNum2;

    /** 휴대폰번호3 */
    private String phoneNum3;

    /** 주소 */
    private String address;

    /** 생년월일 */
    private String birth;

    /** 이메일 */
    private String email;

    /** 직업 */
    private String job;

    /** 소속 */
    private String team;

    /** 기력(CU003) */
    private String level;

    /** 기력(CU003) */
    private String levelNm;

    /** 기존 패스워드 */
    private String oldPW;

    /** 변경 패스워드 */
    private String newPW;

    /** 변경 패스워드 체크 */
    private String newPWcheck;

}
