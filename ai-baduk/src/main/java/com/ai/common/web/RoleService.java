package com.ai.common.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.ai.common.dao.RoleMapper;

@Service
public class RoleService {

	@Autowired
	RoleMapper roleMapper;

	/**
	 * @implNote select menuId.
	 * @param forwordUrl
	 * @return
	 */
	@Cacheable
	public String selectMenuId(String forwordUrl) {
		return roleMapper.selectMenuId(forwordUrl);
	}

	/**
	 * @implNote select permCnt.
	 * @param menuId, roleId
	 * @return
	 */
	@Cacheable
	public String selectPermCnt(String menuId, String roleId) {
		return roleMapper.selectPermCnt(menuId, roleId);
	}

}
