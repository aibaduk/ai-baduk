package com.ai.admin.vo;

import java.util.List;

import com.ai.common.vo.BaseVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class MenuVo extends BaseVo {

	/** 메뉴ID */
	private String menuId;

	/** 메뉴명 */
	private String menuNm;

	/** 상위메뉴ID */
	private String upMenuId;

	/** 메뉴단계 */
	private String menuDepth;

	/** 메뉴경로 */
	private String menuUrl;

	/** 활성화여부 */
	private String visibleYn;

	/** 노출여부 */
	private String dpYn;

	/** 정렬순서 */
	private String sortSeq;

	/** 메모 */
	private String etc;

	/** 룰ID */
	private String roleId;

	/** 룰 리스트 */
	private List<String> roleList;

	/** 룰 리스트 */
	private List<RoleMenuVo> roleMenuList;

}
