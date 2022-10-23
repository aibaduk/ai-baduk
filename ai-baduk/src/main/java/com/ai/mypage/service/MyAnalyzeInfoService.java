package com.ai.mypage.service;

import java.util.List;

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
	 * @implNote select analyzeInfoId list.
	 * @param analyzeInfoVo
	 * @return List<String>
	 */
	public List<String> analyzeInfoIdList(MyAnalyzeInfoVo analyzeInfoVo) {
		return myAnalyzeInfoMapper.analyzeInfoIdList(analyzeInfoVo);
	}
	/**
	 * @implNote select analyze info.
	 * @param analyzeInfoVo
	 * @return MyAnalyzeInfoVo
	 */
	public MyAnalyzeInfoVo selectAnalyzeInfoOne(MyAnalyzeInfoVo analyzeInfoVo) {
		return myAnalyzeInfoMapper.selectAnalyzeInfoOne(analyzeInfoVo);
	}

}
