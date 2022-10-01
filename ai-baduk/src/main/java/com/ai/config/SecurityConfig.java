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
public class SecurityConfig extends WebSecurityConfigurerAdapter {

	private final AuthService authService;

	@Bean
	PasswordEncoder getPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	RoleHierarchy roleHierarchy() {
		RoleHierarchyImpl roleHierarchy = new RoleHierarchyImpl();

		Map<String, List<String>> roleHierarchyMap = new HashMap<>();
		roleHierarchyMap.put("ROLE_ADMIN", Arrays.asList("ROLE_USER"));

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
                .antMatchers("/", "/auth/login", "/auth/logout", "/auth/fail").permitAll()
                .antMatchers("/chrome-download", "/gibo-download").permitAll()
                .antMatchers("/introduce/**").permitAll()
                .antMatchers("/board/**").permitAll()
        		.antMatchers("/admin/**").hasRole("ADMIN")
        		.antMatchers("/mypage/**").hasRole("USER")
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
        auth.userDetailsService(authService).passwordEncoder(new BCryptPasswordEncoder());
    }
}
