package com.ai.mypage.dao;

import org.apache.ibatis.annotations.Mapper;

import com.ai.mypage.vo.AnalyzeInfoVo;

/**
 * @author 우동하
 * @since 2022. 08. 28
 * @implSpec 분석정보 database connection.
 */
@Mapper
public interface AnalyzeInfoMapper {
	/**
	 * @implNote select analyze info.
	 * @param analyzeInfoVo
	 * @return AnalyzeInfoVo
	 */
	public AnalyzeInfoVo selectAnalyzeInfoOne(AnalyzeInfoVo analyzeInfoVo);

}
