package com.ai.board.web;

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

import com.ai.board.service.BoardService;
import com.ai.board.vo.BoardFileVo;
import com.ai.board.vo.BoardSearchVo;
import com.ai.board.vo.BoardVo;
import com.ai.common.util.Constants;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 08. 05
 * @implSpec board controller view.
 */
@Controller
@RequestMapping("/board")
@Slf4j
public class BoardController {

	@Autowired
	BoardService boardService;

	/**
	 * @implNote notice main.
	 * @param model
	 * @return
	 */
	@GetMapping("/notice/main")
	public String noticeMain(Model model) {
		return "board/notice/noticeMain";
	}

	/**
	 * @implNote questions main.
	 * @param model
	 * @return
	 */
	@GetMapping("/questions/main")
	public String questionsMain(Model model) {
		return "board/questions/questionsMain";
	}

	/**
	 * @implNote info main.
	 * @param model
	 * @return
	 */
	@GetMapping("/info/main")
	public String aiInfoMain(Model model) {
		return "board/info/infoMain";
	}

	/**
	 * @implNote storage main.
	 * @param model
	 * @return
	 */
	@GetMapping("/storage/main")
	public String storageMain(Model model) {
		return "board/storage/storageMain";
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
	 * @implNote notice insert.
	 * @param model
	 * @return
	 */
	@GetMapping("/notice/insert")
	public String noticeInsert(Model model) {
		return "board/notice/noticeDetail";
	}

	/**
	 * @implNote page notice detail Linked and select board info.
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/notice/detail")
	public String noticeDetail(Model model, BoardVo boardVo) {
		model.addAttribute("noticeDetailInfo", boardService.selectBoardOne(boardVo));
		return "board/notice/noticeDetail";
	}

	/**
	 * @implNote insert board and file upload.
	 * @param boardVo
	 * @return
	 */
	@PostMapping("/notice/insert")
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
	@PostMapping("/notice/update")
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
	@PostMapping("/notice/delete")
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
	@PostMapping("/notice/fileDelete")
	public String deleteBoardFile(Model model, @RequestBody BoardFileVo boardFileVo) {
		try {
			boardService.deleteBoardFile(boardFileVo);
			model.addAttribute("boardId", boardFileVo.getBoardId());
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
	@GetMapping("/notice/fileDownload")
	public ResponseEntity<Resource> boardFileDownload(Model model, BoardFileVo boardFileVo) throws IOException {
		return boardService.boardFileDownload(boardFileVo);
	}

	/**
	 * @implNote download board zipFile.
	 * @param response
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/notice/zipFileDownload")
	public String zipFileDownload(Model model, HttpServletResponse response, BoardVo boardVo) {
		try {
			boardService.zipFileDownload(response, boardVo);
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

}
