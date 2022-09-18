package com.ai.admin.vo;

import com.ai.common.vo.BaseVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class CodeVo extends BaseVo {

	/** 대분류코드 */
	private String lCd;

	/** 대분류코드 */
	private String upperCodeId;

	/** 중분류코드 */
	private String mCd;

	/** 중분류코드 */
	private String codeId;

	/** 코드명 */
	private String codeNm;

	/** 정렬순번 */
	private String sortSeq;

	/** 비고1 */
	private String ref1;

	/** 비고2 */
	private String ref2;

	/** 비고3 */
	private String ref3;

	/** 메모 */
	private String etc;

}
