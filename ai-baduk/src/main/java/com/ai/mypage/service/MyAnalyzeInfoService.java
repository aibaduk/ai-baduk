package com.ai.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ai.mypage.dao.MyAnalyzeInfoMapper;
import com.ai.mypage.vo.MyAnalyzeInfoVo;

/**
 * @author 우동하
 * @since 2022. 08. 28
 * @implSpec 분석정보 service business logic.
 */
@Service
public class MyAnalyzeInfoService {

	@Autowired
	MyAnalyzeInfoMapper myAnalyzeInfoMapper;

	/**
	 * @implNote select analyze info.
	 * @param analyzeInfoVo
	 * @return AnalyzeInfoVo
	 */
	public MyAnalyzeInfoVo selectAnalyzeInfoOne(MyAnalyzeInfoVo analyzeInfoVo) {
		return myAnalyzeInfoMapper.selectAnalyzeInfoOne(analyzeInfoVo);
	}

}
