package com.ai.mypage.web;

import java.io.IOException;
import java.util.Iterator;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ai.common.vo.RestResult;
import com.ai.common.web.ExcelService;
import com.ai.mypage.service.AnalyzeInfoService;
import com.ai.mypage.vo.AnalyzeInfoVo;

import lombok.extern.slf4j.Slf4j;

/**
 * @author 우동하
 * @since 2022. 08. 28
 * @implSpec 분석정보 controller view.
 */
@Controller
@RequestMapping("/mypage/analyzeInfo")
@Slf4j
public class AnalyzeInfoController {

	@Autowired
	AnalyzeInfoService analyzeInfoService;

	@Autowired
	ExcelService excelService;

	/**
	 * @implNote page analyzeInfo detail Linked and select analyzeInfo.
	 * @param analyzeInfoVo
	 * @return
	 */
	@GetMapping("/detail")
	public String analyzeInfoDetail(Model model, AnalyzeInfoVo analyzeInfoVo) {
		model.addAttribute("analyzeInfoDetail", analyzeInfoService.selectAnalyzeInfoOne(analyzeInfoVo));
		return "mypage/analyzeInfo/analyzeInfoDetail";
	}

	/**
	 * @implNote
	 * @param
	 * @return
	 */
	@GetMapping("/download")
	public String analyzeInfoDown(Model model) {
		return "excel/excelDown";
	}

	/**
	 * @implNote 업로드 샘플 양식 다운로드
	 * @param model
	 * @param response
	 * @return
	 */
	@GetMapping(value="/sample-download")
	public void sampleExcelDown(Model model, HttpServletResponse response) throws IOException {
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
    	response.setHeader("Content-Disposition", "attachment;filename=샘플분석정보.xlsx"); // 저장될 파일명 지정
    	wb.write(response.getOutputStream());
    	wb.close();
	}

	@GetMapping(value="/excel-download")
	public void excelDown(Model model, HttpServletResponse response, AnalyzeInfoVo analyzeInfoVo) throws IOException {
		String sheetName = "분석정보";
		String[] titleList = {"회원ID"
				,"분석정보ID"
				,"바둑성향"
				,"승리패턴"};
		// analyzeInfoVo userId/기간정보를 통한 데이터 추출
		// 추출된 데이터를 엑셀데이터로 변환 후 화면에 다운로드 처리
		Workbook wb = analyzeInfoService.excelDown(sheetName, titleList, analyzeInfoVo);

    	response.setContentType("ms-vnd/excel");
    	response.setHeader("Content-Disposition", "attachment;filename=분석정보15111.xlsx"); // 저장될 파일명 지정
    	wb.write(response.getOutputStream());
    	wb.close();
	}

	@GetMapping("/upload")
	public String analyzeInfoUpload(Model model) {
		return "excel/excelUpload";
	}

	@PostMapping(value="/excelUpload")
	public ResponseEntity<RestResult> excelUp(MultipartHttpServletRequest request, HttpServletResponse response) {
		RestResult rrVO = new RestResult();
		response.setCharacterEncoding("UTF-8");
		try {
			MultipartFile file = null;
			Iterator<String> iterator = request.getFileNames();
			// Excel 파일 가져오기
			if (iterator.hasNext()) {
				file = request.getFile(iterator.next());
			}
			rrVO = excelService.excelUpload(file);
			return new ResponseEntity<>(rrVO, HttpStatus.OK);
	    } catch (Exception e) {
        	log.debug(e.toString());
            return new ResponseEntity<>(rrVO, HttpStatus.OK);
        }
	}

}
