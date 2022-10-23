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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ai.admin.service.AnalyzeInfoService;
import com.ai.admin.vo.AnalyzeInfoSearchVo;
import com.ai.admin.vo.AnalyzeInfoVo;
import com.ai.common.exception.BizException;
import com.ai.common.util.Constants;
import com.ai.common.vo.PageResult;
import com.ai.common.vo.pageInfoVo;
import com.ai.common.web.ExcelService;
import com.github.pagehelper.PageInfo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 10. 18
 * @implSpec analyzeInfo controller view.
 */
@Controller
@RequestMapping("/admin/analyzeInfo")
@Slf4j
public class AnalyzeInfoController {

	@Autowired
	AnalyzeInfoService analyzeInfoService;

	@Autowired
	ExcelService excelService;

	/**
	 * @implNote analyzeInfo main.
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String analyzeInfoMain(Model model) {
		return "admin/analyzeInfo/analyzeInfoMain";
	}

	/**
	 * @implNote select analyzeInfo list.
	 * @param analyzeInfoSearchVo
	 * @return
	 */
	@RequestMapping("/select-list")
	public String selectAnalyzeInfoList(Model model, AnalyzeInfoSearchVo analyzeInfoSearchVo) {
		final PageInfo<AnalyzeInfoVo> pageInfo = analyzeInfoService.selectAnalyzeInfoList(analyzeInfoSearchVo);
		model.addAttribute("result", new PageResult<List<AnalyzeInfoVo>>(new pageInfoVo(pageInfo), pageInfo.getList()));
		log.debug("#######selectAnalyzeInfoList: {}");
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote analyzeInfo detail.
	 * @param model
	 * @return
	 */
	@GetMapping("/insert")
	public String analyzeInfoDetail(Model model) {
		return "admin/analyzeInfo/analyzeInfoDetail";
	}

	/**
	 * @implNote page analyzeInfo detail Linked and select analyzeInfo info.
	 * @param analyzeInfoVo
	 * @return
	 */
	@GetMapping("/detail")
	public String analyzeInfoDetail(Model model, AnalyzeInfoVo analyzeInfoVo) {
    	model.addAttribute("analyzeInfoDetailInfo", analyzeInfoService.selectAnalyzeInfoOne(analyzeInfoVo));
		return "admin/analyzeInfo/analyzeInfoDetail";
	}

	/**
	 * @implNote save analyzeInfo.
	 * @param analyzeInfoVo
	 * @return
	 */
	@PostMapping("/save")
	public String mergeAnalyzeInfo(Model model, AnalyzeInfoVo analyzeInfoVo) {
		try {
			analyzeInfoService.mergeAnalyzeInfo(analyzeInfoVo);
			model.addAttribute("analyzeInfo", analyzeInfoVo);
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote delete analyzeInfo.
	 * @param analyzeInfoList
	 * @return
	 */
	@PostMapping("/delete")
	public String deleteAnalyzeInfo(Model model, @RequestBody List<AnalyzeInfoVo> analyzeInfoList) {
		try {
			analyzeInfoService.deleteAnalyzeInfo(analyzeInfoList);
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}

	/**
	 * @implNote select user list.
	 * @param userVo
	 * @return
	 */
	@PostMapping("/user-search")
	public String selectUserList(Model model, String keyword) {
		try {
			model.addAttribute("userList", analyzeInfoService.selectUserList(keyword));
			model.addAttribute("result", true);
		} catch (BizException e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
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
	public void analyzeInfoExcelDownload(Model model, HttpServletResponse response, AnalyzeInfoSearchVo analyzeInfoSearchVo) throws IOException {
		String sheetName = "분석정보";
		String[] titleList = {
				"회원ID",
				"분석정보ID",
				"바둑성향",
				"승리패턴"
		};
		// 추출된 데이터를 엑셀데이터로 변환 후 화면에 다운로드 처리
		Workbook wb = analyzeInfoService.analyzeInfoExcelDownload(sheetName, titleList, analyzeInfoSearchVo);

    	response.setContentType("ms-vnd/excel");
    	response.setHeader("Content-Disposition", "attachment;filename=분석정보15111.xlsx"); // 저장될 파일명 지정
    	wb.write(response.getOutputStream());
    	wb.close();
	}

	@PostMapping("/excel-upload")
	public String analyzeInfoExcelUpload(Model model, @RequestParam("file") MultipartFile file) {
		try {
			analyzeInfoService.analyzeInfoExcelUpload(file);
			model.addAttribute("result", true);
		} catch (Exception e) {
	    	model.addAttribute("msg", e.getMessage());
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

	@GetMapping("/upload")
	public String analyzeInfoUpload(Model model) {
		return "admin/excel/excelUpload";
	}
}
