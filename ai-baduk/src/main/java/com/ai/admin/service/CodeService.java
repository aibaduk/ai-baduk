package com.ai.admin.service;

import java.io.IOException;
import java.util.List;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ai.admin.dao.CodeMapper;
import com.ai.admin.vo.CodeSearchVo;
import com.ai.admin.vo.CodeVo;
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
	 * @implNote insert board and file upload.
	 * @param boardVo
	 * @param fileList
	 * @return
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	@Transactional
	public String insertCode(List<CodeVo> codeList) {
//		// 1. boardId 채번.
//		String boardId = boardMapper.selectBoardId(boardVo.getBoardGubun());
//		// 2. file 경로 설정 (기본경로 + 메뉴경로 + 채번)
//		String uploadPath = UPLOAD_DEFAULT_PATH + NOTICE_PATH + boardId;
//		// 3. file upload / board_file insert
//		if (!Objects.isNull(fileList)) {
//			for (MultipartFile multi : fileList) {
//				if (!multi.isEmpty()) {
//					String fileNm = UUID.randomUUID().toString();
//					String fileOgNm = multi.getOriginalFilename();
//					fileService.fileUpload(uploadPath, fileNm, fileOgNm, multi);
//					BoardFileVo boardFileVo = new BoardFileVo();
//					boardFileVo.setBoardId(boardId);
//					boardFileVo.setBoardGubun(boardVo.getBoardGubun());
//					boardFileVo.setFileNm(fileNm);
//					boardFileVo.setFileOgNm(fileOgNm);
//					boardMapper.insertBordFile(boardFileVo);
//				}
//			}
//		}
//		// 4. board insert
//		boardVo.setBoardId(boardId);
//		boardMapper.insertBoard(boardVo);
		return "";
	}

}
