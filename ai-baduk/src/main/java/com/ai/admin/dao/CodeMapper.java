package com.ai.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.admin.vo.CodeSearchVo;
import com.ai.admin.vo.CodeVo;

/**
 * @author 우동하
 * @since 2022. 08. 22
 * @implSpec code database connection.
 */
@Mapper
public interface CodeMapper {
	/**
	 * @implNote select code list.
	 * @param codeSearchVo
	 * @return List<CodeVo>
	 */
	public List<CodeVo> selectCodeList(CodeSearchVo codeSearchVo);

	/**
	 * @implNote select lcd code by list.
	 * @param lCd
	 * @return CodeVo
	 */
	public List<CodeVo> selectCodeByLCd(String lCd);

	/**
	 * @implNote select code list.
	 * @param lCd
	 * @return CodeVo
	 */
	public List<CodeVo> selectCode(String lCd);

}
