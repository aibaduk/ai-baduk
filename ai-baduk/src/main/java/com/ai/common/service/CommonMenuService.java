package com.ai.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ai.common.dao.CommonMenuMapper;
import com.ai.common.vo.CommonMenuVo;

@Service
public class CommonMenuService {

	@Autowired
	CommonMenuMapper commonMenuMapper;

	/**
	 * @implNote select top menu.
	 * @param roleId
	 * @return List<CommonMenuVo>
	 */
	public List<CommonMenuVo> selectTopMenu(String roleId) {
		return commonMenuMapper.selectTopMenu(roleId);
	}
}
