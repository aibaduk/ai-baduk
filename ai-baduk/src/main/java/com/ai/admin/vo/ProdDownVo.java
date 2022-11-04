package com.ai.admin.vo;

import com.ai.common.vo.BaseVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ProdDownVo extends BaseVo {

	/** 메뉴ID */
	private String menuId;

	/** 메뉴명 */
	private String menuNm;

	/** 상품ID */
	private String prodId;

	/** 상품구분코드(CU005) */
	private String prodClCd;

	/** 상품구분코드명(CU005) */
	private String prodClNm;

	/** 다운로드ID */
	private String downId;

	/** 사용자ID */
	private String userId;

	/** 사용자명 */
	private String userNm;

	/** 다운로드상태(CU006) */
	private String downStatus;

	/** 다운로드상태명(CU006) */
	private String downStatusNm;

	/** 다운로드수 */
	private String downCnt;

	/** 상품할인율 */
	private String prodDiscountRate;

	/** 상품명 */
	private String prodNm;

	/** 상품가격 */
	private String prodPrice;
}
