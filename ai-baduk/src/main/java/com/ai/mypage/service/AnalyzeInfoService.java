package com.ai.mypage.service;

import java.io.IOException;
import java.util.List;

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
import org.springframework.stereotype.Service;

import com.ai.mypage.dao.AnalyzeInfoMapper;
import com.ai.mypage.vo.AnalyzeInfoVo;

/**
 * @author 우동하
 * @since 2022. 08. 28
 * @implSpec 분석정보 service business logic.
 */
@Service
public class AnalyzeInfoService {

	@Autowired
	AnalyzeInfoMapper analyzeInfoMapper;

	/**
	 * @implNote select analyze info.
	 * @param analyzeInfoVo
	 * @return AnalyzeInfoVo
	 */
	public AnalyzeInfoVo selectAnalyzeInfoOne(AnalyzeInfoVo analyzeInfoVo) {
		return analyzeInfoMapper.selectAnalyzeInfoOne(analyzeInfoVo);
	}

	/**
	 * @implNote common excel sample download.
	 * @param sheetName
	 * @param titleList
	 * @return Workbook
	 * @throws Exception
	 * @throws IOException Workbook
	 */
	public Workbook excelDown(final String sheetName, final String[] titleList, final AnalyzeInfoVo analyzeInfoVo) throws IOException {
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

        List<AnalyzeInfoVo> analyzeInfoList = analyzeInfoMapper.selectAnalyzeInfoList(analyzeInfoVo);
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

}
