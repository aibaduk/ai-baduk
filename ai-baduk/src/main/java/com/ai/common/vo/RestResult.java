package com.ai.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class RestResult {

	/** 결과코드 */
	private String resultCode;

	/** 결과메시지 */
	private String resultMsg;

	/** 쿼리결과 */
	private int result;

}
