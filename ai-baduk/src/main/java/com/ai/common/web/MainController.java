package com.ai.common.web;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @author 우동하
 * @since 2022. 08. 18
 * @implSpec main controller view.
 */
@Controller
public class MainController {

	@Autowired
	FileService fileService;

	@Value("${upload.default.path}")
	private String UPLOAD_DEFAULT_PATH;

	@Value("${upload.chrome.path}")
	private String CHROME_PATH;

	@Value("${upload.gibo.path}")
	private String GIBO_PATH;

	/**
	 * @implNote main.
	 * @param model
	 * @return
	 */
//	@GetMapping({"/", "/main"})
//	public String noticeMain(Model model) {
//		return "common/main";
//	}

	/**
	 * @implNote download chrome file.
	 * @return
	 * @throws IOException
	 */
	@GetMapping("/chrome-download")
	public ResponseEntity<Resource> chromeDownload(Model model) throws IOException {
		String uploadPath = UPLOAD_DEFAULT_PATH + CHROME_PATH;
		return fileService.fileDownload(uploadPath, "ChromeSetup.exe", "ChromeSetup.exe");
	}

	/**
	 * @implNote download gibo file.
	 * @return
	 * @throws IOException
	 */
	@GetMapping("/gibo-download")
	public ResponseEntity<Resource> giboDownload(Model model) throws IOException {
		String uploadPath = UPLOAD_DEFAULT_PATH + GIBO_PATH;
		return fileService.fileDownload(uploadPath, "giboEdit.exe", "giboEdit.exe");
	}

}
