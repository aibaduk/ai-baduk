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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.board.service.PubBoardService;
import com.ai.board.vo.PubBoardSearchVo;
import com.ai.board.vo.PubBoardVo;
import com.ai.common.util.Constants;
import com.ai.common.vo.FileVo;
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
public class PubBoardController {

	@Autowired
	PubBoardService boardService;

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
	 * @implNote question main.
	 * @param model
	 * @return
	 */
	@GetMapping("/question/main")
	public String questionMain(Model model) {
		return "board/question/questionMain";
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
	public String selectBoardList(Model model, PubBoardSearchVo boardSearchVo) {
		final PageInfo<PubBoardVo> pageInfo = boardService.selectBoardList(boardSearchVo);
		model.addAttribute("result", new PageResult<List<PubBoardVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
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
	public String noticeDetail(Model model, PubBoardVo boardVo) {
		model.addAttribute("noticeDetailInfo", boardService.selectBoardOne(boardVo));
		return "board/notice/noticeDetail";
	}

	/**
	 * @implNote question insert.
	 * @param model
	 * @return
	 */
	@GetMapping("/question/insert")
	public String questionInsert(Model model) {
		return "board/question/questionDetail";
	}

	/**
	 * @implNote page question detail Linked and select board info.
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/question/detail")
	public String questionDetail(Model model, PubBoardVo boardVo) {
		model.addAttribute("questionDetailInfo", boardService.selectBoardOne(boardVo));
		return "board/question/questionDetail";
	}

	/**
	 * @implNote info insert.
	 * @param model
	 * @return
	 */
	@GetMapping("/info/insert")
	public String infoInsert(Model model) {
		return "board/info/infoDetail";
	}

	/**
	 * @implNote page info detail Linked and select board info.
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/info/detail")
	public String infoDetail(Model model, PubBoardVo boardVo) {
		model.addAttribute("infoDetailInfo", boardService.selectBoardOne(boardVo));
		return "board/info/infoDetail";
	}

	/**
	 * @implNote storage insert.
	 * @param model
	 * @return
	 */
	@GetMapping("/storage/insert")
	public String storageInsert(Model model) {
		return "board/storage/storageDetail";
	}

	/**
	 * @implNote page notice detail Linked and select board info.
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/storage/detail")
	public String storageDetail(Model model, PubBoardVo boardVo) {
		model.addAttribute("storageDetailInfo", boardService.selectBoardOne(boardVo));
		return "board/storage/storageDetail";
	}

	/**
	 * @implNote insert board and file upload.
	 * @param boardVo
	 * @return
	 */
//	@PostMapping("/{path}/insert")
//	public String insertBoard(Model model
//			, @PathVariable("path") String path
//			, PubBoardVo boardVo
//			, @RequestParam(value="uploadFiles", required = false) List<MultipartFile> fileList
//			) {
//		try {
//			model.addAttribute("boardId", boardService.insertBoard(boardVo, fileList));
//			model.addAttribute("result", true);
//		} catch (Exception e) {
//			model.addAttribute("msg", e.getMessage());
//		}
//		return Constants.JSON_VIEW;
//	}

	/**
	 * @implNote update board and file upload.
	 * @param boardVo
	 * @return
	 */
//	@PostMapping("/{path}/update")
//	public String updateBoard(Model model
//			, @PathVariable("path") String path
//			, PubBoardVo boardVo
//			, @RequestParam(value="uploadFiles", required = false) List<MultipartFile> fileList
//			) {
//		try {
//			boardService.updateBoard(boardVo, fileList);
//			model.addAttribute("boardId", boardVo.getBoardId());
//			model.addAttribute("result", true);
//		} catch (Exception e) {
//			model.addAttribute("msg", e.getMessage());
//		}
//		return Constants.JSON_VIEW;
//	}

	/**
	 * @implNote delete board.
	 * @param boardList
	 * @return
	 */
//	@PostMapping("/{path}/delete")
//	public String deleteBoard(Model model, @PathVariable("path") String path, @RequestBody List<PubBoardVo> boardList) {
//		try {
//			boardService.deleteBoard(boardList);
//			model.addAttribute("result", true);
//		} catch (Exception e) {
//			model.addAttribute("msg", e.getMessage());
//		}
//		return Constants.JSON_VIEW;
//	}

	/**
	 * @implNote delete board file.
	 * @param boardVo
	 * @return
	 */
//	@PostMapping("/{path}/fileDelete")
//	public String deleteBoardFile(Model model, @PathVariable("path") String path, @RequestBody FileVo fileVo) {
//		try {
//			String targetId = fileVo.getTargetId();
//			boardService.deleteBoardFile(fileVo);
//			model.addAttribute("boardId", targetId);
//			model.addAttribute("result", true);
//		} catch (Exception e) {
//			model.addAttribute("msg", e.getMessage());
//		}
//		return Constants.JSON_VIEW;
//	}

	/**
	 * @implNote download board file.
	 * @param boardVo
	 * @return
	 * @throws IOException
	 */
	@GetMapping("/{path}/fileDownload")
	public ResponseEntity<Resource> boardFileDownload(Model model, @PathVariable("path") String path, FileVo fileVo) throws IOException {
		return boardService.boardFileDownload(fileVo);
	}

	/**
	 * @implNote download board zipFile.
	 * @param response
	 * @param boardVo
	 * @return
	 */
	@GetMapping("/{path}/zipFileDownload")
	public void zipFileDownload(Model model, @PathVariable("path") String path, HttpServletResponse response, PubBoardVo boardVo) {
		String zipFileName = path + ".zip";
		boardService.zipFileDownload(zipFileName, response, boardVo);
	}

}
