package com.ai.admin.service;

import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.ai.admin.dao.ProductMapper;
import com.ai.admin.vo.ProductSearchVo;
import com.ai.admin.vo.ProductVo;
import com.ai.common.util.Constants;
import com.ai.common.vo.FileVo;
import com.ai.common.web.CommonService;
import com.ai.common.web.FileService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 10. 24
 * @implSpec product service business logic.
 */
@Service
public class ProductService {

	@Autowired
	ProductMapper productMapper;

	@Autowired
	FileService fileService;

	@Value("${upload.default.path}")
	private String UPLOAD_DEFAULT_PATH;

	@Value("${upload.product.opening.path}")
	private String OPENING_PATH;

	@Value("${upload.product.pattern.path}")
	private String PATTERN_PATH;

	@Value("${upload.product.endGame.path}")
	private String ENDGAME_PATH;

	@Value("${upload.product.haengma.path}")
	private String HAENGMA_PATH;

	/**
	 * @implNote select product list.
	 * @param productSearchVo
	 * @return PageInfo<ProductVo>
	 */
	public PageInfo<ProductVo> selectProductList(ProductSearchVo productSearchVo) {
		PageHelper.startPage(productSearchVo.getPageNo(), productSearchVo.getPageSize());

		PageInfo<ProductVo> productList = new PageInfo<ProductVo>(productMapper.selectProductList(productSearchVo), productSearchVo.getNavigatePages());
		int index = productSearchVo.getPageNo() * productSearchVo.getPageSize() - 10 + 1;
		IntStream.range(0, productList.getList().size())
		         .forEach(i -> {
		        	 productList.getList().get(i).setRowId(String.valueOf(index + i));
		         });

		return productList;
	}

	/**
	 * @implNote select lcd product by list.
	 * @param lCd
	 * @return List<ProductVo>
	 */
	public ProductVo selectProductOne(ProductVo productVo) {
		return productMapper.selectProductOne(productVo);
	}

	/**
	 * @implNote insert product.
	 * @param productVo
	 * @return ProductVo
	 */
	@Transactional
	public ProductVo insertProduct(ProductVo productVo, List<MultipartFile> fileList) throws IllegalStateException, IOException {
		// 1. 상품ID 채번.
		String prodId = productMapper.selectProdId(productVo.getProdClCd());
		// 2. file 경로 설정 (기본경로 + 상품구분경로 + 채번)
		String uploadPath = getUploadPath(productVo.getProdClCd(), prodId);
		// 3. file upload / product_file insert
		if (!Objects.isNull(fileList)) {
			for (MultipartFile multi : fileList) {
				if (!multi.isEmpty()) {
					String fileNm = UUID.randomUUID().toString();
					String fileOgNm = multi.getOriginalFilename();
					fileService.fileUpload(uploadPath, fileNm, fileOgNm, multi);
					FileVo fileVo = new FileVo();
					CommonService.setSessionData(fileVo);
					fileVo.setChnlId(Constants.FILE_CHNL_PROD);
					fileVo.setTargetId(prodId);
					fileVo.setTargetGubun(productVo.getProdClCd());
					fileVo.setFileNm(fileNm);
					fileVo.setFileOgNm(fileOgNm);
					fileService.insertFile(fileVo);
				}
			}
		}
		// 4. product insert
		CommonService.setSessionData(productVo);
		productVo.setProdId(prodId);
		productMapper.insertProduct(productVo);
		return productVo;
	}

	/**
	 * @implNote update product.
	 * @param productVo
	 * @return
	 */
	@Transactional
	public void updateProduct(ProductVo productVo, List<MultipartFile> fileList) throws IllegalStateException, IOException {
		// 1. file 경로 설정 (기본경로 + 메뉴경로 + 채번)
		String prodId = productVo.getProdId();
		String uploadPath = getUploadPath(productVo.getProdClCd(), prodId);
		// 2. file upload / product_file insert
		if (!Objects.isNull(fileList)) {
			for (MultipartFile multi : fileList) {
				if (!multi.isEmpty()) {
					String fileNm = UUID.randomUUID().toString();
					String fileOgNm = multi.getOriginalFilename();
					fileService.fileUpload(uploadPath, fileNm, fileOgNm, multi);
					FileVo fileVo = new FileVo();
					CommonService.setSessionData(fileVo);
					fileVo.setChnlId(Constants.FILE_CHNL_PROD);
					fileVo.setTargetId(prodId);
					fileVo.setTargetGubun(productVo.getProdClCd());
					fileVo.setFileNm(fileNm);
					fileVo.setFileOgNm(fileOgNm);
					fileService.insertFile(fileVo);
				}
			}
		}
		// 3. board update
		CommonService.setSessionData(productVo);
		productMapper.updateProduct(productVo);
	}

	/**
	 * @implNote delete file.
	 * @param fileVo
	 * @return
	 */
	@Transactional
	public void deleteProductFile(FileVo fileVo) {
		// 1. 파일경로상에 있는 물리적인 파일 삭제
		String uploadPath = getUploadPath(fileVo.getTargetGubun(), fileVo.getTargetId());
		fileService.fileDelete(uploadPath, fileVo.getFileNm());
		// 2. 데이터베이스 파일 테이블 삭제
		fileService.deleteFile(fileVo);
	}

	/**
	 * @implNote download file.
	 * @param fileVo
	 * @return
	 * @throws IOException
	 */
	public ResponseEntity<Resource> productFileDownload(FileVo fileVo) throws IOException {
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
