package com.ai.config;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Bean;
import org.springframework.security.access.expression.SecurityExpressionHandler;
import org.springframework.security.access.hierarchicalroles.RoleHierarchy;
import org.springframework.security.access.hierarchicalroles.RoleHierarchyImpl;
import org.springframework.security.access.hierarchicalroles.RoleHierarchyUtils;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.expression.DefaultWebSecurityExpressionHandler;

import com.ai.auth.service.AuthService;

import lombok.RequiredArgsConstructor;

@EnableWebSecurity
@RequiredArgsConstructor
public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {

	private final AuthService authService;

	/** 사용자 관리 패스워드 인코더 사용시 필요 추가 */
	@Bean
	PasswordEncoder getPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}

	/** 권한 관련 하위 권한 추가시 필요 */
	@Bean
	RoleHierarchy roleHierarchy() {
		RoleHierarchyImpl roleHierarchy = new RoleHierarchyImpl();

		Map<String, List<String>> roleHierarchyMap = new HashMap<>();
		roleHierarchyMap.put("ROLE_ADMIN", Arrays.asList("ROLE_MEMBER", "ROLE_USER"));
		roleHierarchyMap.put("ROLE_MEMBER", Arrays.asList("ROLE_USER"));

		String roles = RoleHierarchyUtils.roleHierarchyFromMap(roleHierarchyMap);
		roleHierarchy.setHierarchy(roles);

		return roleHierarchy;
	}
	@Bean
	SecurityExpressionHandler<FilterInvocation> expressionHandler() {
		DefaultWebSecurityExpressionHandler webSecurityExpressionHandler = new DefaultWebSecurityExpressionHandler();
		webSecurityExpressionHandler.setRoleHierarchy(roleHierarchy());
		return webSecurityExpressionHandler;
	}

	/** 로그인 시 hideUserNotFoundExceptions를 설정을 안하면
	  * 무조건 BCryptPasswordEncoder로 처리됨.
	  * false 처리 시 CustomFailureHandler에서 다양한 형태의 exception 처리 가능
	  */
	@Bean
	DaoAuthenticationProvider daoAuthenticationProvider() {
		DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
		authenticationProvider.setUserDetailsService(authService);
		authenticationProvider.setPasswordEncoder(getPasswordEncoder());
		authenticationProvider.setHideUserNotFoundExceptions(false);
		return authenticationProvider;
	}

    /**
     * 규칙 설정
     * @param http
     * @throws Exception
     */
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.csrf().disable();
        http.authorizeRequests()
        		.antMatchers("/static/**").permitAll()
                .antMatchers("/").permitAll()
                .antMatchers("/auth/login").permitAll()
                .antMatchers("/auth/logout").permitAll()
                .antMatchers("/auth/fail").permitAll()
                .antMatchers("/chrome-download", "/gibo-download").permitAll()
                .antMatchers("/introduce/**").permitAll()
                .antMatchers("/board/**").permitAll()
        		.antMatchers("/admin/**").hasRole("ADMIN")
        		.antMatchers("/mypage/analyzeInfo/**").hasRole("MEMBER")
        		.antMatchers("/mypage/user/**").hasRole("USER")
        		.anyRequest().authenticated();
        http.exceptionHandling()
        		.accessDeniedHandler(new CustomAccessDeniedHandler());
        http.formLogin()
        		.loginPage("/auth/login")
        		.loginProcessingUrl("/auth/login_proc")
        		.failureHandler(new CustomFailureHandler());
        http.logout()
        		.logoutUrl("/auth/logout")
        		.logoutSuccessUrl("/")
        		.invalidateHttpSession(true);
    }

    /**
     * 로그인 인증 처리 메소드
     * @param auth
     * @throws Exception
     */
    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
//        auth.userDetailsService(authService).passwordEncoder(new BCryptPasswordEncoder());
        auth.authenticationProvider(daoAuthenticationProvider());
    }
}
