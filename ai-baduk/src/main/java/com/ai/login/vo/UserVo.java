package com.ai.login.vo;

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.Data;

@Data
@SuppressWarnings("serial")
public class UserVo implements UserDetails {
    private String userId;
    private String userNm;
    private String userSex;
    private String userAuth;
    private String userPw;
    private String userGrade;
    private String phoneNum1;
    private String phoneNum2;
    private String phoneNum3;
    private String address;
    private String birth;
    private String email;
    private String job;
    private String team;
    private String level;
    private String ssLoginId;

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return Collections.singletonList(new SimpleGrantedAuthority(this.userAuth));
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return this.userPw;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return this.userId;
	}

	public String getUserNm() {
		// TODO Auto-generated method stub
		return this.userNm;
	}

	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}

	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

}
