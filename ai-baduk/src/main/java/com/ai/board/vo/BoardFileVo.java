package com.ai.board.vo;

import com.ai.common.vo.BaseVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class BoardFileVo extends BaseVo {

	/** 게시판ID */
	private String boardId;

	/** 게시판구분 */
	private String boardGubun;

	/** 파일ID */
	private String fileId;

	/** 파일명 */
	private String fileNm;

	/** 파일원본명 */
	private String fileOgNm;

}
