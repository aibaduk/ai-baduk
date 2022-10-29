package com.ai.product.vo;

import com.ai.common.vo.BaseVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PubProductVo extends BaseVo {

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

	/** new여부 */
	private String newYn;

}
