package com.ai.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ai.admin.vo.AnalyzeInfoSearchVo;
import com.ai.admin.vo.AnalyzeInfoVo;
import com.ai.admin.vo.UserVo;

/**
 * @author 우동하
 * @since 2022. 10. 18
 * @implSpec analyzeInfo database connection.
 */
@Mapper
public interface AnalyzeInfoMapper {
	/**
	 * @implNote select analyzeInfo list.
	 * @param analyzeInfoSearchVo
	 * @return List<AnalyzeInfoVo>
	 */
	public List<AnalyzeInfoVo> selectAnalyzeInfoList(AnalyzeInfoSearchVo analyzeInfoSearchVo);

	/**
	 * @implNote select analyzeInfo info.
	 * @param userVo
	 * @return AnalyzeInfoVo
	 */
	public AnalyzeInfoVo selectAnalyzeInfoOne(AnalyzeInfoVo analyzeInfoVo);

	/**
	 * @implNote merge analyzeInfo.
	 * @param analyzeInfoVo
	 * @return
	 */
	public int mergeAnalyzeInfo(AnalyzeInfoVo analyzeInfoVo);

	/**
	 * @implNote delete analyzeInfo.
	 * @param analyzeInfoVo
	 * @return
	 */
	public int deleteAnalyzeInfo(AnalyzeInfoVo analyzeInfoVo);

	/**
	 * @implNote select user list.
	 * @param keyword
	 * @return List<UserVo>
	 */
	public List<UserVo> selectUserList(String keyword);

	/**
	 * @implNote select user list.
	 * @param keyword
	 * @return List<UserVo>
	 */
	public List<AnalyzeInfoVo> selectStatisicsList(@Param("keyword") String keyword
			, @Param("from") String from
			, @Param("to") String to
			, @Param("value") String value);

}
