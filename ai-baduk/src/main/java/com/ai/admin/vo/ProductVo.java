package com.ai.admin.vo;

import java.util.List;

import com.ai.common.vo.BaseVo;
import com.ai.common.vo.FileVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ProductVo extends BaseVo {

	/** 상품ID */
	private String prodId;

	/** 상품명 */
	private String prodNm;

	/** 상품구분코드(CU005) */
	private String prodClCd;

	/** 상품구분코드(CU005) */
	private String prodClNm;

	/** 전시여부 */
	private String displayYn;

	/** 상품할인율 */
	private String prodDiscountRate;

	/** 상품가격 */
	private String prodPrice;

	/** 상품판매처 */
	private String prodMarket;

	/** 상품내용 */
	private String prodCtt;

	/** 파일첨부여부 */
	private String fileYn;

	/** 파일갯수 */
	private String fileCnt;

	/** 파일ID */
	private String fileId;

	/** 파일명 */
	private String fileNm;

	/** 파일원본명 */
	private String fileOgNm;

	/** 파일리스트 */
	private List<FileVo> fileList;

}
