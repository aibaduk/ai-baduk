package com.ai.board.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.stream.IntStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ai.board.dao.BoardMapper;
import com.ai.board.vo.BoardFileVo;
import com.ai.board.vo.BoardSearchVo;
import com.ai.board.vo.BoardVo;
import com.ai.common.web.CommonService;
import com.ai.common.web.FileService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 08. 05
 * @implSpec board service business logic.
 */
@Service
public class BoardService {

	@Autowired
	FileService fileService;

	@Autowired
	BoardMapper boardMapper;

	@Value("${upload.default.path}")
	private String UPLOAD_DEFAULT_PATH;

	@Value("${upload.board.notice.path}")
	private String NOTICE_PATH;

	@Value("${upload.board.question.path}")
	private String QUESTION_PATH;

	@Value("${upload.board.info.path}")
	private String INFO_PATH;

	@Value("${upload.board.storage.path}")
	private String STORAGE_PATH;

	/**
	 * @implNote select board list.
	 * @param boardSearchVo
	 * @return PageInfo<BoardVo>
	 */
	public PageInfo<BoardVo> selectBoardList(BoardSearchVo boardSearchVo) {
		PageHelper.startPage(boardSearchVo.getPageNo(), boardSearchVo.getPageSize());

		PageInfo<BoardVo> boardList = new PageInfo<BoardVo>(boardMapper.selectBoardList(boardSearchVo), boardSearchVo.getNavigatePages());
		int index = "PC".equals(boardSearchVo.getChnlGubun()) ? boardSearchVo.getPageNo() * boardSearchVo.getPageSize() - 10 + 1 : 1;
		IntStream.range(0, boardList.getList().size())
		         .forEach(i -> {
		        	 boardList.getList().get(i).setRowId(String.valueOf(index + i));
		         });


//		return new PageInfo<BoardVo>(boardMapper.selectBoardList(boardSearchVo), boardSearchVo.getNavigatePages());
		return boardList;
	}

	/**
	 * @implNote select board info.
	 * @param boardVo
	 * @return BoardVo
	 */
	public BoardVo selectBoardOne(BoardVo boardVo) {
		return boardMapper.selectBoardOne(boardVo);
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
	public String insertBoard(BoardVo boardVo, List<MultipartFile> fileList) throws IllegalStateException, IOException {
		// 1. boardId 채번.
		String boardId = boardMapper.selectBoardId(boardVo.getBoardGubun());
		// 2. file 경로 설정 (기본경로 + 메뉴경로 + 채번)
		String uploadPath = getUploadPath(boardVo.getBoardGubun(), boardId);
		// 3. file upload / board_file insert
		if (!Objects.isNull(fileList)) {
			for (MultipartFile multi : fileList) {
				if (!multi.isEmpty()) {
					String fileNm = UUID.randomUUID().toString();
					String fileOgNm = multi.getOriginalFilename();
					fileService.fileUpload(uploadPath, fileNm, fileOgNm, multi);
					BoardFileVo boardFileVo = new BoardFileVo();
					CommonService.setSessionData(boardFileVo);
					boardFileVo.setBoardId(boardId);
					boardFileVo.setBoardGubun(boardVo.getBoardGubun());
					boardFileVo.setFileNm(fileNm);
					boardFileVo.setFileOgNm(fileOgNm);
					boardMapper.insertBordFile(boardFileVo);
				}
			}
		}
		// 4. board insert
		CommonService.setSessionData(boardVo);
		boardVo.setBoardId(boardId);
		boardMapper.insertBoard(boardVo);
		return boardId;
	}

	/**
	 * @implNote update board.
	 * @param boardVo
	 * @return
	 */
	@Transactional
	public void updateBoard(BoardVo boardVo, List<MultipartFile> fileList) throws IllegalStateException, IOException {
		// 2. file 경로 설정 (기본경로 + 메뉴경로 + 채번)
		String boardId = boardVo.getBoardId();
		String uploadPath = getUploadPath(boardVo.getBoardGubun(), boardId);
		// 3. file upload / board_file insert
		if (!Objects.isNull(fileList)) {
			for (MultipartFile multi : fileList) {
				if (!multi.isEmpty()) {
					String fileNm = UUID.randomUUID().toString();
					String fileOgNm = multi.getOriginalFilename();
					fileService.fileUpload(uploadPath, fileNm, fileOgNm, multi);
					BoardFileVo boardFileVo = new BoardFileVo();
					CommonService.setSessionData(boardFileVo);
					boardFileVo.setBoardId(boardId);
					boardFileVo.setBoardGubun(boardVo.getBoardGubun());
					boardFileVo.setFileNm(fileNm);
					boardFileVo.setFileOgNm(fileOgNm);
					boardMapper.insertBordFile(boardFileVo);
				}
			}
		}
		// 4. board insert
		CommonService.setSessionData(boardVo);
		boardMapper.updateBoard(boardVo);
	}

	/**
	 * @implNote delete board.
	 * @param boardVo
	 * @return
	 */
	@Transactional
	public void deleteBoard(List<BoardVo> boardList) {
		boardList.stream().forEach(board -> {
			CommonService.setSessionData(board);
			boardMapper.deleteBoard(board);
		});
	}

	/**
	 * @implNote delete board file.
	 * @param boardVo
	 * @return
	 */
	@Transactional
	public void deleteBoardFile(BoardFileVo boardFileVo) {
		// 1. 파일경로상에 있는 물리적인 파일 삭제
		String uploadPath = getUploadPath(boardFileVo.getBoardGubun(), boardFileVo.getBoardId());
		fileService.fileDelete(uploadPath, boardFileVo.getFileNm());
		// 2. 데이터베이스 파일 테이블 삭제
		boardMapper.deleteBoardFile(boardFileVo);
	}

	/**
	 * @implNote delete board file.
	 * @param boardVo
	 * @return
	 * @throws IOException
	 */
	public ResponseEntity<Resource> boardFileDownload(BoardFileVo boardFileVo) throws IOException {
		String boardId = boardFileVo.getBoardId();
		String fileNm = boardFileVo.getFileNm();
		String fileOgNm = boardFileVo.getFileOgNm();
		String uploadPath = getUploadPath(boardFileVo.getBoardGubun(), boardId);
		return fileService.fileDownload(uploadPath, fileNm, fileOgNm);
	}

	/**
	 * @implNote delete board zipFile.
	 * @param response
	 * @param boardVo
	 * @return
	 */
	public void zipFileDownload(String zipFileName, HttpServletResponse response, BoardVo boardVo) {
		List<BoardFileVo> boardFileList = boardMapper.selectBoardFile(boardVo);
		List<String> fileList = new ArrayList<>();
		String uploadPath = getUploadPath(boardVo.getBoardGubun(), boardVo.getBoardId());
		boardFileList.forEach(file -> {
			fileList.add(String.format("%s/%s_%s", uploadPath, file.getFileNm(), file.getFileOgNm()));
		});
		fileService.zipFileDownload(response, zipFileName, fileList);
	}

	private String getUploadPath(final String boardGubun, final String boardId) {
		StringBuilder sb = new StringBuilder();
		String path = "";
		switch (boardGubun) {
		case "01":
			path = NOTICE_PATH;
			break;
		case "02":
			path = QUESTION_PATH;
			break;
		case "03":
			path = INFO_PATH;
			break;
		case "04":
			path = STORAGE_PATH;
			break;
		default:
			break;
		}
		return sb.append(UPLOAD_DEFAULT_PATH).append(path).append(boardId).toString();
	}

	/**
	 * @implNote select board list by main.
	 * @param boardGubun
	 * @param size
	 * @return List<BoardVo>
	 */
	public List<BoardVo> selectBoardListByExternal(final String boardGubun, final int dateControlDay, final int size) {
		return boardMapper.selectBoardListByExternal(boardGubun, dateControlDay, size);
	}
}
