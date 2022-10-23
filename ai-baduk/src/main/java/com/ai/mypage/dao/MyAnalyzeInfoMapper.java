package com.ai.mypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.mypage.vo.MyAnalyzeInfoVo;

/**
 * @author 우동하
 * @since 2022. 08. 28
 * @implSpec 분석정보 database connection.
 */
@Mapper
public interface MyAnalyzeInfoMapper {
	/**
	 * @implNote select analyzeInfoId list.
	 * @param analyzeInfoVo
	 * @return AnalyzeInfoVo
	 */
	public List<String> analyzeInfoIdList(MyAnalyzeInfoVo analyzeInfoVo);

	/**
	 * @implNote select analyze info.
	 * @param analyzeInfoVo
	 * @return AnalyzeInfoVo
	 */
	public MyAnalyzeInfoVo selectAnalyzeInfoOne(MyAnalyzeInfoVo analyzeInfoVo);

}
