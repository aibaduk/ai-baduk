package com.ai.admin.service;

import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.stream.IntStream;

import org.apache.poi.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ai.admin.dao.ProdMapper;
import com.ai.admin.vo.ProdSearchVo;
import com.ai.admin.vo.ProdVo;
import com.ai.common.util.Constants;
import com.ai.common.vo.FileVo;
import com.ai.common.web.CommonService;
import com.ai.common.web.FileService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 10. 24
 * @implSpec prod service business logic.
 */
@Service
public class ProdService {

	@Autowired
	ProdMapper prodMapper;

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
	 * @implNote select prod list.
	 * @param prodSearchVo
	 * @return PageInfo<ProdVo>
	 */
	public PageInfo<ProdVo> selectProdList(ProdSearchVo prodSearchVo) {
		PageHelper.startPage(prodSearchVo.getPageNo(), prodSearchVo.getPageSize());

		PageInfo<ProdVo> prodList = new PageInfo<ProdVo>(prodMapper.selectProdList(prodSearchVo), prodSearchVo.getNavigatePages());
		int index = prodSearchVo.getPageNo() * prodSearchVo.getPageSize() - 10 + 1;
		IntStream.range(0, prodList.getList().size())
		         .forEach(i -> {
		        	 prodList.getList().get(i).setRowId(String.valueOf(index + i));
		         });

		return prodList;
	}

	/**
	 * @implNote select prod by list.
	 * @param prodVo
	 * @return List<ProdVo>
	 */
	public ProdVo selectProdOne(ProdVo prodVo) {
		return prodMapper.selectProdOne(prodVo);
	}

	/**
	 * @implNote insert prod.
	 * @param prodVo
	 * @return ProdVo
	 */
	@Transactional
	public ProdVo insertProd(ProdVo prodVo, List<MultipartFile> fileList) throws IllegalStateException, IOException {
		// 1. 상품ID 채번.
		String prodId = prodMapper.selectProdId(prodVo.getProdClCd());
		// 2. file 경로 설정 (기본경로 + 상품구분경로 + 채번)
		String uploadPath = getUploadPath(prodVo.getProdClCd(), prodId);
		// 3. file upload / prod_file insert
		if (!Objects.isNull(fileList)) {
			for (MultipartFile multi : fileList) {
				if (!multi.isEmpty()) {
					String fileNm = UUID.randomUUID().toString();
					String fileOgNm = multi.getOriginalFilename();
					fileService.fileUpload(uploadPath, fileNm, fileOgNm, multi);
					FileVo fileVo = new FileVo();
					CommonService.setSessionData(fileVo);
					fileVo.setMenuId(Constants.FILE_CHNL_PROD);
					fileVo.setTargetId(StringUtil.join("", new Object[]{prodId, prodVo.getProdClCd()}));
					fileVo.setFileNm(fileNm);
					fileVo.setFileOgNm(fileOgNm);
					fileService.insertFile(fileVo);
				}
			}
		}
		// 4. prod insert
		CommonService.setSessionData(prodVo);
		prodVo.setProdId(prodId);
		prodMapper.insertProd(prodVo);
		return prodVo;
	}

	/**
	 * @implNote update prod.
	 * @param prodVo
	 * @return
	 */
	@Transactional
	public void updateProd(ProdVo prodVo, List<MultipartFile> fileList) throws IllegalStateException, IOException {
		// 1. file 경로 설정 (기본경로 + 메뉴경로 + 채번)
		String prodId = prodVo.getProdId();
		String uploadPath = getUploadPath(prodVo.getProdClCd(), prodId);
		// 2. file upload / prod_file insert
		if (!Objects.isNull(fileList)) {
			for (MultipartFile multi : fileList) {
				if (!multi.isEmpty()) {
					String fileNm = UUID.randomUUID().toString();
					String fileOgNm = multi.getOriginalFilename();
					fileService.fileUpload(uploadPath, fileNm, fileOgNm, multi);
					FileVo fileVo = new FileVo();
					CommonService.setSessionData(fileVo);
					fileVo.setMenuId(Constants.FILE_CHNL_PROD);
					fileVo.setTargetId(StringUtil.join("", new Object[]{prodId, prodVo.getProdClCd()}));
					fileVo.setFileNm(fileNm);
					fileVo.setFileOgNm(fileOgNm);
					fileService.insertFile(fileVo);
				}
			}
		}
		// 3. board update
		CommonService.setSessionData(prodVo);
		prodMapper.updateProd(prodVo);
	}

	/**
	 * @implNote delete file.
	 * @param fileVo
	 * @return
	 */
	@Transactional
	public void deleteProdFile(FileVo fileVo) {
		// 1. 파일경로상에 있는 물리적인 파일 삭제
		String uploadPath = getUploadPath(fileVo.getTargetGubun(), fileVo.getTargetId());
		fileService.fileDelete(uploadPath, fileVo.getFileNm());
		// 2. 데이터베이스 파일 테이블 삭제
		fileVo.setTargetId(StringUtil.join("", new Object[]{fileVo.getTargetId(), fileVo.getTargetGubun()}));
		fileService.deleteFile(fileVo);
	}

	/**
	 * @implNote download file.
	 * @param fileVo
	 * @return
	 * @throws IOException
	 */
	public ResponseEntity<Resource> prodFileDownload(FileVo fileVo) throws IOException {
		String boardId = fileVo.getTargetId();
		String fileNm = fileVo.getFileNm();
		String fileOgNm = fileVo.getFileOgNm();
		String uploadPath = getUploadPath(fileVo.getTargetGubun(), boardId);
		return fileService.fileDownload(uploadPath, fileNm, fileOgNm);
	}

	private String getUploadPath(final String prodClCd, final String prodId) {
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
