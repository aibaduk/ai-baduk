package com.ai.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class FileVo extends BaseVo {

	/** 메뉴ID */
	private String menuId;

	/** 대상ID */
	private String targetId;

	/** 파일ID */
	private String fileId;

	/** 파일명 */
	private String fileNm;

	/** 파일원본명 */
	private String fileOgNm;

	/** 대상구분 */
	private String targetGubun;

}
