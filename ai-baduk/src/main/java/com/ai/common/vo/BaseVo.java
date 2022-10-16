package com.ai.common.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public abstract class BaseVo {
	protected @JsonIgnore int pageNo = 1;
	protected @JsonIgnore int pageSize = 10;
	protected @JsonIgnore int navigatePages = 10;
	private String chnlGubun;
	private String fstCrerId;
	private String fstCrerNm;
	private String fstCreDtm;
	private String auditId;
	private String auditNm;
	private String auditDtm;
	private String rowId;
	private int ssDateControlDay = 7;
	protected String ssLoginId;
	protected String ssRoleId;
}
