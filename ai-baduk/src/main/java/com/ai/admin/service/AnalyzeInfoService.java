package com.ai.admin.service;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.IntStream;

import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ai.admin.dao.AnalyzeInfoMapper;
import com.ai.admin.vo.AnalyzeInfoSearchVo;
import com.ai.admin.vo.AnalyzeInfoVo;
import com.ai.admin.vo.UserVo;
import com.ai.common.web.CommonService;
import com.ai.common.web.ExcelService;
import com.ai.common.web.FileService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 10. 18
 * @implSpec analyzeInfo service business logic.
 */
@Service
public class AnalyzeInfoService {

	@Autowired
	AnalyzeInfoMapper analyzeInfoMapper;

	@Autowired
	FileService fileService;

	@Autowired
	ExcelService excelService;

	@Value("${upload.default.path}")
	private String UPLOAD_DEFAULT_PATH;

	@Value("${upload.excel.analyze_info.path}")
	private String ANALYZE_INFO_PATH;


	/**
	 * @implNote select analyzeInfo list.
	 * @param analyzeInfoSearchVo
	 * @return PageInfo<AnalyzeInfoVo>
	 */
	public PageInfo<AnalyzeInfoVo> selectAnalyzeInfoList(AnalyzeInfoSearchVo analyzeInfoSearchVo) {
		PageHelper.startPage(analyzeInfoSearchVo.getPageNo(), analyzeInfoSearchVo.getPageSize());

		PageInfo<AnalyzeInfoVo> userList = new PageInfo<AnalyzeInfoVo>(analyzeInfoMapper.selectAnalyzeInfoList(analyzeInfoSearchVo), analyzeInfoSearchVo.getNavigatePages());
		int index = analyzeInfoSearchVo.getPageNo() * analyzeInfoSearchVo.getPageSize() - 10 + 1;
		IntStream.range(0, userList.getList().size())
		         .forEach(i -> {
		        	 userList.getList().get(i).setRowId(String.valueOf(index + i));
		         });

		return userList;
	}

	/**
	 * @implNote select analyzeInfo info.
	 * @param analyzeInfoVo
	 * @return AnalyzeInfoVo
	 */
	public AnalyzeInfoVo selectAnalyzeInfoOne(AnalyzeInfoVo analyzeInfoVo) {
		return analyzeInfoMapper.selectAnalyzeInfoOne(analyzeInfoVo);
	}

	/**
	 * @implNote merge analyzeInfo.
	 * @param analyzeInfoVo
	 * @return
	 */
	@Transactional
	public void mergeAnalyzeInfo(AnalyzeInfoVo analyzeInfoVo) {
		CommonService.setSessionData(analyzeInfoVo);
		analyzeInfoMapper.mergeAnalyzeInfo(analyzeInfoVo);
	}

	/**
	 * @implNote delete analyzeInfo.
	 * @param analyzeInfoList
	 * @return
	 */
	@Transactional
	public void deleteAnalyzeInfo(List<AnalyzeInfoVo> analyzeInfoList) {
		analyzeInfoList.stream().forEach(analyzeInfo -> {
			CommonService.setSessionData(analyzeInfo);
			analyzeInfoMapper.deleteAnalyzeInfo(analyzeInfo);
		});
	}

	/**
	 * @implNote select user list.
	 * @param keyword
	 * @return List<UserVo>
	 */
	public List<UserVo> selectUserList(String keyword) {
		return analyzeInfoMapper.selectUserList(keyword);
	}

	/**
	 * @implNote analyzeInfo excel download.
	 * @param sheetName
	 * @param titleList
	 * @param analyzeInfoVo
	 * @return Workbook
	 * @throws Exception
	 * @throws IOException Workbook
	 */
	public Workbook analyzeInfoExcelDownload(final String sheetName, final String[] titleList, final AnalyzeInfoSearchVo analyzeInfoSearchVo) throws IOException {
		Workbook wb = new XSSFWorkbook();
    	Sheet sheet = wb.createSheet(sheetName);
    	Row row = null;
    	Cell cell = null;
    	int rowNum = 1;

        // 헤더 스타일 지정
        CellStyle cellStyle = wb.createCellStyle();
        cellStyle.setBorderTop(BorderStyle.THIN);
        cellStyle.setBorderBottom(BorderStyle.THIN);
        cellStyle.setBorderLeft(BorderStyle.THIN);
        cellStyle.setBorderRight(BorderStyle.THIN);
        // 셀 배경색 지정
        cellStyle.setFillForegroundColor(HSSFColorPredefined.GREY_25_PERCENT.getIndex());
        cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);

        row = sheet.createRow(0); // 행 생성
        for (int i=0; i<titleList.length; i++) {
            cell = row.createCell(i); // 셀 생성
            cell.setCellStyle(cellStyle); // 셀 스타일 지정
            cell.setCellValue(titleList[i]); // 셀에 표시될 문구 지정
        }

        List<AnalyzeInfoVo> analyzeInfoList = analyzeInfoMapper.selectAnalyzeInfoList(analyzeInfoSearchVo);
        if (!analyzeInfoList.isEmpty()) {
        	for (AnalyzeInfoVo vo : analyzeInfoList) {
        		row = sheet.createRow(rowNum++);
        		cell = row.createCell(0);
        		cell.setCellValue(vo.getUserId());
        		cell = row.createCell(1);
        		cell.setCellValue(vo.getAnalyzeInfoId());
        		cell = row.createCell(2);
        		cell.setCellValue(vo.getBadukTendency());
        		cell = row.createCell(3);
        		cell.setCellValue(vo.getVictoryPattern());
        	}
        }
		return wb;
	}

	/**
	 * @implNote analyzeInfo excel upload.
	 * @return
	 */
	@Transactional
	public void analyzeInfoExcelUpload(final MultipartFile multi) throws IllegalStateException, IOException {
		// 1. 파일 업로드
		String absolutePath = fileService.fileUpload(UPLOAD_DEFAULT_PATH + ANALYZE_INFO_PATH, multi.getOriginalFilename(), multi);
		// 2. 엑셀 데이터 read
		List<String> columnList = Arrays.asList("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
				"Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "AA", "AB", "AC", "AD", "AE", "AF", "AG", "AH");
		List<Map<String, String>> applyList = excelService.excelRead(absolutePath, 2, columnList);
		// 3. 데이터베이스 merge
		for (Map<String, String> apply : applyList) {
			AnalyzeInfoVo analyzeInfoVo = new AnalyzeInfoVo();
			CommonService.setSessionData(analyzeInfoVo);
			analyzeInfoVo.setUserId(apply.get("A"));
			analyzeInfoVo.setAnalyzeInfoId(apply.get("B"));
			analyzeInfoVo.setBadukTendency(apply.get("C"));
			analyzeInfoVo.setVictoryPattern(apply.get("D"));
			analyzeInfoVo.setBp(apply.get("E"));
			analyzeInfoVo.setIbm(apply.get("F"));
			analyzeInfoVo.setTarget(apply.get("G"));
			analyzeInfoVo.setOpening(apply.get("H"));
			analyzeInfoVo.setOpeningStarting(apply.get("I"));
			analyzeInfoVo.setOpeningAiMatchRate(apply.get("J"));
			analyzeInfoVo.setOpeningAiGraph(apply.get("K"));
			analyzeInfoVo.setOpeningMissRate(apply.get("L"));
			analyzeInfoVo.setMiddleGame(apply.get("M"));
			analyzeInfoVo.setMiddleGameCombativePower(apply.get("N"));
			analyzeInfoVo.setMiddleGameSaveRate(apply.get("O"));
			analyzeInfoVo.setMiddleGameMissCnt(apply.get("P"));
			analyzeInfoVo.setMiddleGameMissRate(apply.get("Q"));
			analyzeInfoVo.setEndGame(apply.get("R"));
			analyzeInfoVo.setEndGameDefense(apply.get("S"));
			analyzeInfoVo.setEndGameDefenseFailure(apply.get("T"));
			analyzeInfoVo.setEndGameTurnTheTables(apply.get("U"));
			analyzeInfoVo.setEndGameMissCnt(apply.get("V"));
			analyzeInfoVo.setGameTiming(apply.get("W"));
			analyzeInfoVo.setGameTimingWave(apply.get("X"));
			analyzeInfoVo.setGameTimingDefence(apply.get("Y"));
			analyzeInfoVo.setTechnique(apply.get("Z"));
			analyzeInfoVo.setTechniqueValueJudgment(apply.get("AA"));
			analyzeInfoVo.setTechniqueHaengma(apply.get("AB"));
			analyzeInfoVo.setTechniqueReading(apply.get("AC"));
			analyzeInfoVo.setExamOpeningPositionalJudgment(apply.get("AD"));
			analyzeInfoVo.setExamHaengmaValueJudgment(apply.get("AE"));
			analyzeInfoVo.setExamReadingLifeAndDeath(apply.get("AF"));
			analyzeInfoVo.setExamEndGameCounting(apply.get("AG"));
			analyzeInfoVo.setEtc(apply.get("AH"));
			analyzeInfoMapper.mergeAnalyzeInfo(analyzeInfoVo);
		}
	}

}
