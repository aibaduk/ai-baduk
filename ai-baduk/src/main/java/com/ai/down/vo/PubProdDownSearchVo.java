package com.ai.down.vo;

import com.ai.common.vo.BaseVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class PubProdDownSearchVo extends BaseVo {
	private String searchKey;
	private String searchValue;
	private String searchUserId;
}
