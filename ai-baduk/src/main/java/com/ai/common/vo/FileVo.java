package com.ai.common.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class FileVo extends BaseVo {

	/** 채널ID */
	private String chnlId;

	/** 타켓ID */
	private String targetId;

	/** 타켓구분 */
	private String targetGubun;

	/** 파일ID */
	private String fileId;

	/** 파일명 */
	private String fileNm;

	/** 파일원본명 */
	private String fileOgNm;

}
