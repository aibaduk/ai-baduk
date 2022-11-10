package com.ai.admin.vo;

import com.ai.common.vo.BaseVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class RoleMenuVo extends BaseVo {

	/** 메뉴ID */
	private String menuId;

	/** 룰ID */
	private String roleId;

}
