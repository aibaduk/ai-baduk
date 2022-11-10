package com.ai.admin.vo;

import java.util.List;

import com.ai.common.vo.BaseVo;
import com.ai.common.vo.FileVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class BoardVo extends BaseVo {

	/** 게시판ID */
	private String boardId;

	/** 게시판명 */
	private String boardNm;

	/** 게시판구분 */
	private String boardGubun;

	/** 삭제여부 */
	private String delYn;

	/** 중요도여부 */
	private String impoYn;

	/** 게시판제목 */
	private String boardTit;

	/** 게시판내용 */
	private String boardCtt;

	/** 파일첨부여부 */
	private String fileYn;

	/** 파일갯수 */
	private String fileCnt;

	/** 파일ID */
	private String fileId;

	/** 파일명 */
	private String fileNm;

	/** 파일원본명 */
	private String fileOgNm;

	/** 파일리스트 */
	private List<FileVo> fileList;

	/** new여부 */
	private String newYn;

}
