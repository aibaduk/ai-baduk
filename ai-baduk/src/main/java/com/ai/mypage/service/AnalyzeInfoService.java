package com.ai.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ai.mypage.dao.AnalyzeInfoMapper;
import com.ai.mypage.vo.AnalyzeInfoVo;

/**
 * @author 우동하
 * @since 2022. 08. 28
 * @implSpec 분석정보 service business logic.
 */
@Service
public class AnalyzeInfoService {

	@Autowired
	AnalyzeInfoMapper analyzeInfoMapper;

	/**
	 * @implNote select analyze info.
	 * @param analyzeInfoVo
	 * @return AnalyzeInfoVo
	 */
	public AnalyzeInfoVo selectAnalyzeInfoOne(AnalyzeInfoVo analyzeInfoVo) {
		return analyzeInfoMapper.selectAnalyzeInfoOne(analyzeInfoVo);
	}

}
