package com.ai.common.vo;

import com.github.pagehelper.PageInfo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class pageInfoVo {
	private long totalCount;
	private int pageNo;
	private int pageSize;
	private int prePage;
	private int nextPage;
	private int lastPage;
	private int navigatePages;

	public pageInfoVo(PageInfo<?> pageInfo) {
		this.totalCount = pageInfo.getTotal();
		this.pageNo = pageInfo.getPageNum();
		this.pageSize = pageInfo.getPageSize();
		this.prePage = pageInfo.getPrePage();
		this.nextPage = pageInfo.getNextPage();
		this.lastPage = pageInfo.getPages();
		this.navigatePages = pageInfo.getNavigatePages();
	}
}
