package com.ai.admin.service;

import java.util.List;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ai.admin.dao.CodeMapper;
import com.ai.admin.vo.CodeSearchVo;
import com.ai.admin.vo.CodeVo;
import com.ai.common.web.CommonService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 08. 22
 * @implSpec code service business logic.
 */
@Service
public class CodeService {

	@Autowired
	CodeMapper codeMapper;

	/**
	 * @implNote select code list.
	 * @param codeSearchVo
	 * @return PageInfo<CodeVo>
	 */
	public PageInfo<CodeVo> selectCodeList(CodeSearchVo codeSearchVo) {
		PageHelper.startPage(codeSearchVo.getPageNo(), codeSearchVo.getPageSize());

		PageInfo<CodeVo> codeList = new PageInfo<CodeVo>(codeMapper.selectCodeList(codeSearchVo), codeSearchVo.getNavigatePages());
		int index = codeSearchVo.getPageNo() * codeSearchVo.getPageSize() - 10 + 1;
		IntStream.range(0, codeList.getList().size())
		         .forEach(i -> {
		        	 codeList.getList().get(i).setRowId(String.valueOf(index + i));
		         });

		return codeList;
	}

	/**
	 * @implNote select lcd code by list.
	 * @param lCd
	 * @return List<CodeVo>
	 */
	public List<CodeVo> selectCodeByLCd(String lCd) {
		return codeMapper.selectCodeByLCd(lCd);
	}

	/**
	 * @implNote select code list.
	 * @param lCd
	 * @return List<CodeVo>
	 */
	public List<CodeVo> selectCode(String lCd) {
		return codeMapper.selectCode(lCd);
	}

	/**
	 * @implNote merge code.
	 * @param codeVo
	 * @return
	 */
	@Transactional
	public String mergeCode(CodeVo codeVo) {
		// major
		CodeVo majorVo = new CodeVo();
		CommonService.setSessionData(majorVo);
		majorVo.setLCd(codeVo.getMajorId());
		majorVo.setMCd("*");
		majorVo.setCodeNm(codeVo.getMajorNm());
		majorVo.setSortSeq("0");
		codeMapper.mergeCode(majorVo);
		// minor
		codeMapper.deleteCode(majorVo);
		for (CodeVo minorVo : codeVo.getCodeList()) {
			CommonService.setSessionData(minorVo);
			minorVo.setLCd(codeVo.getMajorId());
			minorVo.setMCd(minorVo.getCodeId());
			codeMapper.mergeCode(minorVo);
		}
		return codeVo.getMajorId();
	}

}
