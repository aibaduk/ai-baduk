package com.ai.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PageResult<T> {

	/** 페이지 정보 */
	private pageInfoVo pageInfo;

	/** 데이터 */
	private T data;

	public PageResult(pageInfoVo pageInfo, T data) {
		this.pageInfo = pageInfo;
		this.data = data;
	}
}
