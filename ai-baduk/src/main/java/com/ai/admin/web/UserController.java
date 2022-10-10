package com.ai.admin.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ai.admin.service.CodeService;
import com.ai.admin.service.UserService;
import com.ai.admin.vo.UserSearchVo;
import com.ai.admin.vo.UserVo;
import com.ai.common.exception.BizException;
import com.ai.common.util.Constants;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
import com.ai.common.web.ExcelService;
import com.ai.mypage.service.AnalyzeInfoService;
import com.ai.mypage.vo.AnalyzeInfoVo;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 09. 25
 * @implSpec user controller view.
 */
@Controller
@RequestMapping("/admin/user")
@Slf4j
public class UserController {

	@Autowired
	UserService userService;

	@Autowired
	CodeService codeService;

	@Autowired
	ExcelService excelService;

	@Autowired
	AnalyzeInfoService analyzeInfoService;

	/**
	 * @implNote user main.
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String userMain(Model model) {
		return "admin/user/userMain";
	}

	/**
	 * @implNote select user list.
	 * @param userVo
	 * @return
	 */
	@RequestMapping("/select-list")
	public String selectUserList(Model model, UserSearchVo userSearchVo) {
		final PageInfo<UserVo> pageInfo = userService.selectUserList(userSearchVo);
		model.addAttribute("result", new PageResult<List<UserVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
		log.debug("#######selectUserList: {}");
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote page user detail Linked and select user info.
	 * @param userVo
	 * @return
	 */
	@GetMapping("/detail")
	public String userDetail(Model model, UserVo userVo) {
		model.addAttribute("codeCU001", codeService.selectCode("CU001"));
    	model.addAttribute("codeCU002", codeService.selectCode("CU002"));
    	model.addAttribute("codeCU003", codeService.selectCode("CU003"));
    	model.addAttribute("codeCU004", codeService.selectCode("CU004"));
    	model.addAttribute("userDetailInfo", userService.selectUserOne(userVo));
		return "admin/user/userDetail";
	}

	/**
	 * @implNote update user.
	 * @param userVo
	 * @return
	 */
	@PostMapping("/update")
	public String updateUser(Model model, UserVo userVo) {
		try {
			userService.updateUser(userVo);
			model.addAttribute("userId", userVo.getUserId());
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
			model.addAttribute("code", e.getErrCode());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote update password.
	 * @param userVo
	 * @return
	 */
	@PostMapping("/update-password")
	public String updatePassword(Model model, UserVo userVo) {
		try {
			userService.updatePassword(userVo);
			model.addAttribute("userId", userVo.getUserId());
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
			model.addAttribute("code", e.getErrCode());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote
	 * @param
	 * @return
	 */
	@GetMapping("/download")
	public String analyzeInfoDown(Model model) {
		return "admin/excel/excelDown";
	}

	/**
	 * @implNote 업로드 샘플 양식 다운로드
	 * @param model
	 * @param response
	 * @return
	 */
	@GetMapping(value="/sample-download")
	public void sampleExcelDownload(Model model, HttpServletResponse response) throws IOException {
		String sheetName = "분석정보";
		String[] titleList = {"회원ID"
				,"분석정보ID"
				,"바둑성향"
				,"승리패턴"
				,"BP"
				,"IBM"
				,"목표"
				,"포석"
				,"포석starting"
				,"포석AI일치율"
				,"포석AI그래프"
				,"포석실착률"
				,"중반"
				,"중반전투력"
				,"중반선방율"
				,"중반실착횟수"
				,"중반실착율"
				,"끝내기"
				,"끝내기DEFENSE"
				,"끝내기DEFENSE_FAILURE"
				,"끝내기TURN_THE_TABLES"
				,"끝내기실착횟수"
				,"승부호흡"
				,"승부호흡 흔들기"
				,"승부호흡 수비"
				,"기술"
				,"기술가치판단"
				,"기술행마"
				,"기술수읽기"
				,"시험포석/형세판단"
				,"시험행마/가치판단"
				,"시험수읽기/사활"
				,"시험끝내기/계가"
				,"비고"};
		Workbook wb = excelService.sampleExcelDown(sheetName, titleList);

    	response.setContentType("ms-vnd/excel");
    	response.setHeader("Content-Disposition", "attachment;filename=info.xlsx"); // 저장될 파일명 지정
    	wb.write(response.getOutputStream());
    	wb.close();
	}

	@GetMapping(value="/excel-download")
	public void analyzeInfoExcelDownload(Model model, HttpServletResponse response, AnalyzeInfoVo analyzeInfoVo) throws IOException {
		String sheetName = "분석정보";
		String[] titleList = {
				"회원ID",
				"분석정보ID",
				"바둑성향",
				"승리패턴"
		};
		// analyzeInfoVo userId/기간정보를 통한 데이터 추출
		// 추출된 데이터를 엑셀데이터로 변환 후 화면에 다운로드 처리
		Workbook wb = userService.analyzeInfoExcelDownload(sheetName, titleList, analyzeInfoVo);

    	response.setContentType("ms-vnd/excel");
    	response.setHeader("Content-Disposition", "attachment;filename=분석정보15111.xlsx"); // 저장될 파일명 지정
    	wb.write(response.getOutputStream());
    	wb.close();
	}

	@GetMapping("/upload")
	public String analyzeInfoUpload(Model model) {
		return "admin/excel/excelUpload";
	}

	@PostMapping("/excel-upload")
	public String analyzeInfoExcelUpload(Model model, @RequestParam("file") MultipartFile file) {
		try {
			userService.analyzeInfoExcelUpload(file);
			model.addAttribute("result", true);
		} catch (Exception e) {
	    	model.addAttribute("msg", e.getMessage());
        }
		return Constants.JSON_VIEW;
	}
}
