package com.ai.down.service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ai.common.exception.BizException;
import com.ai.common.util.Constants;
import com.ai.common.vo.FileVo;
import com.ai.common.web.CommonService;
import com.ai.common.web.FileService;
import com.ai.down.dao.PubDownMapper;
import com.ai.down.vo.PubProdDownSearchVo;
import com.ai.down.vo.PubProdDownVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 10. 24
 * @implSpec down service business logic.
 */
@Service
public class PubDownService {

	@Autowired
	PubDownMapper downMapper;

	@Autowired
	FileService fileService;

	@Value("${upload.default.path}")
	private String UPLOAD_DEFAULT_PATH;

	@Value("${upload.prod.opening.path}")
	private String OPENING_PATH;

	@Value("${upload.prod.pattern.path}")
	private String PATTERN_PATH;

	@Value("${upload.prod.endGame.path}")
	private String ENDGAME_PATH;

	@Value("${upload.prod.haengma.path}")
	private String HAENGMA_PATH;

	/**
	 * @implNote select prod down list.
	 * @param downSearchVo
	 * @return PageInfo<DownVo>
	 */
	public PageInfo<PubProdDownVo> selectProdDownList(PubProdDownSearchVo downSearchVo) {
		PageHelper.startPage(downSearchVo.getPageNo(), downSearchVo.getPageSize());

		PageInfo<PubProdDownVo> downList = new PageInfo<PubProdDownVo>(downMapper.selectProdDownList(downSearchVo), downSearchVo.getNavigatePages());
		int index = downSearchVo.getPageNo() * downSearchVo.getPageSize() - 10 + 1;
		IntStream.range(0, downList.getList().size())
		         .forEach(i -> {
		        	 downList.getList().get(i).setRowId(String.valueOf(index + i));
		         });

		return downList;
	}

	/**
	 * @implNote insert prod down.
	 * @param downVo
	 * @return
	 */
	@Transactional
	public void insertProdDown(PubProdDownVo downVo) {
		CommonService.setSessionData(downVo);
		downMapper.insertProdDown(downVo);
	}

	/**
	 * @implNote update prod down status.
	 * @param downVo
	 * @return
	 */
	@Transactional
	public void updateProdDownStatus04(List<PubProdDownVo> downList) {
		downList.stream().forEach(down -> {
			CommonService.setSessionData(down);
			downMapper.updateProdDownStatus04(down);
		});
	}

	/**
	 * @implNote down prod down zipFile.
	 * @param response
	 * @param downVo
	 * @return
	 */
	@Transactional
	public void zipFileDownload(String zipFileName, HttpServletResponse response, PubProdDownVo downVo) {
		// 1. 정상적인 접근 체크
		if (downMapper.selectIsExists(downVo)) {
			throw new BizException("비정상적인 접근입니다.");
		}
		// 2. 다운로드 상태 업데이트 처리
		CommonService.setSessionData(downVo);
		downVo.setMenuId(Constants.FILE_CHNL_PROD);
		downMapper.updateProdDownStatus03(downVo);
		// 3. 파일 다운로드
		FileVo fileVo = new FileVo();
		fileVo.setMenuId(Constants.FILE_CHNL_PROD);
		fileVo.setTargetId(StringUtil.join("", new Object[]{downVo.getProdId(), downVo.getProdClCd()}));
		List<FileVo> boardFileList = fileService.selectFile(fileVo);
		List<String> fileList = new ArrayList<>();
		String uploadPath = getUploadPath(downVo.getProdId(), downVo.getProdClCd());
		boardFileList.forEach(file -> {
			fileList.add(String.format("%s/%s_%s", uploadPath, file.getFileNm(), file.getFileOgNm()));
		});
		fileService.zipFileDownload(response, zipFileName, fileList);
	}

	private String getUploadPath(final String prodId, final String prodClCd) {
		StringBuilder sb = new StringBuilder();
		String path = "";
		switch (prodClCd) {
		case "01":
			path = OPENING_PATH;
			break;
		case "02":
			path = PATTERN_PATH;
			break;
		case "03":
			path = ENDGAME_PATH;
			break;
		case "04":
			path = HAENGMA_PATH;
			break;
		default:
			break;
		}
		return sb.append(UPLOAD_DEFAULT_PATH).append(path).append(prodId).toString();
	}

}
