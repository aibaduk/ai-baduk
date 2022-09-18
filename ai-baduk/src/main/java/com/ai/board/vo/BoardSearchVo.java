package com.ai.board.vo;

import com.ai.common.vo.BaseVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class BoardSearchVo extends BaseVo {
	private String searchBoardGubun;
	private String searchKey;
	private String searchValue;
}
