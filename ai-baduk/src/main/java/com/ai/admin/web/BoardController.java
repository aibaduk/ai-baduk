package com.ai.admin.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ai.admin.service.BoardService;
import com.ai.admin.service.CodeService;
import com.ai.admin.vo.BoardSearchVo;
import com.ai.admin.vo.BoardVo;
import com.ai.common.util.Constants;
import com.ai.common.vo.FileVo;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 11. 10
 * @implSpec board controller view.
 */
@Controller
@RequestMapping("/admin/board")
@Slf4j
public class BoardController {

	@Autowired
	BoardService boardService;

	@Autowired
	CodeService codeService;

	/**
	 * @implNote board main.
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String boardMain(Model model
			, @RequestParam(value="boardGubun", required = false) String boardGubun) {
		model.addAttribute("boardGubun", boardGubun);
		model.addAttribute("codeBO001", codeService.selectCode("BO001"));
		return "admin/board/boardMain";
	}

	/**
	 * @implNote select board list.
	 * @param boardVo
	 * @return
	 */
	@RequestMapping("/select-list")
	public String selectBoardList(Model model, BoardSearchVo boardSearchVo) {
		final PageInfo<BoardVo> pageInfo = boardService.selectBoardList(boardSearchVo);
		model.addAttribute("result", new PageResult<List<BoardVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
		log.debug("#######boardgubun: {}", boardSearchVo.getSearchBoardGubun());
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote board insert.
	 * @param model
	 * @return
	 */
	@GetMapping("/insert")
	public String boardInsert(Model model, BoardVo boardVo) {
		model.addAttribute("boardGubun", boardVo.getBoardGubun());
		model.addAttribute("boardTit", boardVo.getBoardNm());
		return "admin/board/boardDetail";
	}

	/**
	 * @implNote page board detail Linked and select board info.
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/detail")
	public String boardDetail(Model model, BoardVo boardVo) {
		BoardVo resVo = boardService.selectBoardOne(boardVo);
		model.addAttribute("boardGubun", boardVo.getBoardGubun());
		model.addAttribute("boardTit", resVo.getBoardNm());
		model.addAttribute("boardDetailInfo", resVo);
		return "admin/board/boardDetail";
	}
	/**
	 * @implNote insert board and file upload.
	 * @param boardVo
	 * @return
	 */
	@PostMapping("/insert")
	public String insertBoard(Model model
			, BoardVo boardVo
			, @RequestParam(value="uploadFiles", required = false) List<MultipartFile> fileList
			) {
		try {
			model.addAttribute("boardId", boardService.insertBoard(boardVo, fileList));
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote update board and file upload.
	 * @param boardVo
	 * @return
	 */
	@PostMapping("/update")
	public String updateBoard(Model model
			, BoardVo boardVo
			, @RequestParam(value="uploadFiles", required = false) List<MultipartFile> fileList
			) {
		try {
			boardService.updateBoard(boardVo, fileList);
			model.addAttribute("boardId", boardVo.getBoardId());
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote delete board.
	 * @param boardList
	 * @return
	 */
	@PostMapping("/delete")
	public String deleteBoard(Model model, @RequestBody List<BoardVo> boardList) {
		try {
			boardService.deleteBoard(boardList);
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote delete board file.
	 * @param boardVo
	 * @return
	 */
	@PostMapping("/fileDelete")
	public String deleteBoardFile(Model model, @RequestBody FileVo fileVo) {
		try {
			String targetId = fileVo.getTargetId();
			boardService.deleteBoardFile(fileVo);
			model.addAttribute("boardId", targetId);
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote download board file.
	 * @param boardVo
	 * @return
	 * @throws IOException
	 */
	@GetMapping("/fileDownload")
	public ResponseEntity<Resource> boardFileDownload(Model model, FileVo fileVo) throws IOException {
		return boardService.boardFileDownload(fileVo);
	}

	/**
	 * @implNote download board zipFile.
	 * @param response
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/zipFileDownload")
	public void zipFileDownload(Model model, HttpServletResponse response, BoardVo boardVo) {
		String zipFileName = "board.zip";
		boardService.zipFileDownload(zipFileName, response, boardVo);
	}

}
