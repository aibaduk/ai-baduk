package com.ai.common.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StreamUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class FileService {
	/**
	 * @implNote common file upload.
	 * @param uploadPath
	 * @param fileNm
	 * @param fileOgNm
	 * @param multi
	 * @return
	 * @throws IOException
	 * @throws IllegalStateException
	 */
	public void fileUpload(String uploadPath, String fileNm, String fileOgNm, MultipartFile multi) throws IllegalStateException, IOException {
		// 1. 파일 생성
		File file = new File(uploadPath);
		// 2. 파일 디렉토리가 없을시 디렉토리 생성
		if(!file.exists()) {
			file.mkdirs();
		}
		// 3. 실제 저장 파일명 생성
		String saveName = uploadPath + File.separator + fileNm + "_" + fileOgNm;
		// 4. 파일명 기준으로 path 생성
        Path savePath = Paths.get(saveName);
        // 5. MultipartFile transferTo 파일 복사
		multi.transferTo(savePath);
	}

	/**
	 * @implNote common file delete.
	 * @param uploadPath
	 * @param fileNm
	 * @return
	 */
	public boolean fileDelete(String uploadPath, String fileNm) {
		File file = new File(uploadPath + File.separator + fileNm);
        return file.delete();
	}

	/**
	 * @implNote common file download.
	 * @param uploadPath
	 * @param fileNm
	 * @return
	 * @throws IOException
	 */
	public ResponseEntity<Resource> fileDownload(String uploadPath, String fileNm, String fileOgNm) throws IOException {
        // 1. path 설정
		Path path = Paths.get(uploadPath + File.separator + fileNm);
        String contentType = Files.probeContentType(path);
        // 2. header를 통해서 다운로드 되는 파일의 정보를 설정한다.
        HttpHeaders headers = new HttpHeaders();
        // 3. header 생성시 orignalFileNm으로 세팅 후 리턴
        headers.setContentDisposition(ContentDisposition.builder("attachment")
                .filename(fileOgNm, StandardCharsets.UTF_8)
                .build());
        headers.add(HttpHeaders.CONTENT_TYPE, contentType);
        // 화면으로 반환할 리소스 객체 생성
        Resource resource = new InputStreamResource(Files.newInputStream(path));
        return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}

	/**
	 * @implNote common zipFile download.
	 * @param response
	 * @param zipFileName
	 * @param fileList
	 * @throws IOException
	 */
	public void zipFileDownload(HttpServletResponse response, String zipFileName, List<String> fileList) {
        // 1. response 설정
		response.setStatus(HttpServletResponse.SC_OK);
	    response.setContentType("application/zip");
	    response.addHeader("Content-Disposition", "attachment; filename=" + zipFileName);

	    ZipOutputStream zipOut = null;
	    FileInputStream fis = null;

	    try {
	        zipOut = new ZipOutputStream(response.getOutputStream());

	        // File 객체를 생성하여 List에 담는다.
	        List<File> objectFileList = fileList.stream().map(file -> {
	            return new File(file);
	        }).collect(Collectors.toList());

	        // 루프를 돌며 ZipOutputStream에 파일들을 주입한다.
	        for(File file : objectFileList) {
	            zipOut.putNextEntry(new ZipEntry(file.getName()));
	            fis = new FileInputStream(file);

	            StreamUtils.copy(fis, zipOut);

	            fis.close();
	            zipOut.closeEntry();
	        }

	        zipOut.close();

	    } catch (IOException e) {
	        try { if(fis != null)fis.close(); } catch (IOException e1) {log.debug(e1.getMessage());/*ignore*/}
	        try { if(zipOut != null)zipOut.closeEntry();} catch (IOException e2) {log.debug(e2.getMessage());/*ignore*/}
	        try { if(zipOut != null)zipOut.close();} catch (IOException e3) {log.debug(e3.getMessage());/*ignore*/}
	    }
	}
}
