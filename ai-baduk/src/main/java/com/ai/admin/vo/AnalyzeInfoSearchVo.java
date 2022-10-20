package com.ai.admin.vo;

import com.ai.common.vo.BaseVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class AnalyzeInfoSearchVo extends BaseVo {
	private String searchKey;
	private String searchValue;
}
