package com.ai.common.web;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ai.common.vo.RestResult;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ExcelService {
	/**
	 * @implNote common excel sample download.
	 * @param sheetName
	 * @param titleList
	 * @return Workbook
	 * @throws Exception
	 * @throws IOException Workbook
	 */
	public Workbook sampleExcelDown(final String sheetName, final String[] titleList) throws IOException {
		Workbook wb = new XSSFWorkbook();
    	Sheet sheet = wb.createSheet(sheetName);
    	Row row = null;
    	Cell cell = null;

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
		return wb;
	}

	/**
	 * @implNote common excel upload.
	 * @param excelFile
	 * @return RestResult
	 * @throws Exception
	 */
	public RestResult excelUpload(MultipartFile excelFile) throws Exception {
		RestResult rrVO = new RestResult();
		try {
			OPCPackage opcPackage = OPCPackage.open(excelFile.getInputStream()); // 파일 읽어옴
			XSSFWorkbook workbook =  new XSSFWorkbook(opcPackage);

			XSSFSheet sheet = workbook.getSheetAt(0);
			int resultCnt = 0; // DB에 반영된 결과 수 체크용

			// 입력된 행의 수만큼 반복
			for(int i=1;i<=sheet.getLastRowNum();i++) {
//				MemberVO memberVO = new MemberVO();
				XSSFRow row = sheet.getRow(i); // i번째 행 가져옴
				XSSFCell cell = null;

				if(row == null) continue;
				log.debug("====================index====================================" + i);
				// 0번째 열
				cell = row.getCell(0);
				// Cell 값이 null 일 수도 있으므로 체크
				if(cell != null) {
					cell.setCellType(CellType.STRING); // 숫자만 입력받는 경우를 대비해 STRING 처리
					log.debug(cell.getStringCellValue().replace(" ", ""));
//					memverVO.setId(cell.getStringCellValue().replace(" ", "")); // 공백처리
				}

				// 열의 수만큼 반복
				// 1번째 열
				cell = row.getCell(1);
				log.debug(cell.getStringCellValue().replace(" ", ""));
//				if(cell != null) memberVO.setName(cell.getStringCellValue().replace(" ", ""));
//	`
//				int result = memberMapper.InsertMember(paramsMap); // DB에 반영

				// 반영되었는지 체크
//				if (result > 0) {
//					resultCnt++;
//				}
//				else {
//					throw new Exception();
//				}
				resultCnt++;
			}

			// 모든 Row가 반영되었는지 체크
			if(resultCnt == sheet.getLastRowNum()) {
				rrVO.setResultCode("SUCCESS");
				rrVO.setResultMsg("업로드 성공했습니다.");
//				rrVO.setQueryResult(result);
			}

		}
		catch (Exception e) {
			throw e;
		}
		return rrVO;
	}
}
