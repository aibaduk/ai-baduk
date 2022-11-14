package com.ai.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CommonMenuVo extends BaseVo {

	/** 메뉴ID */
	private String menuId;

	/** 메뉴명 */
	private String menuNm;

	/** 메뉴명 */
	private String menuUrl;

	/** 활성화여부 */
	private String visibleYn;

	/** 노출여부 */
	private String dpYn;

	/** 클래스 여부 */
	private String yn;

}
