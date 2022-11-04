package com.ai.admin.service;

import java.util.List;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ai.admin.dao.DownMapper;
import com.ai.admin.vo.ProdDownSearchVo;
import com.ai.admin.vo.ProdDownVo;
import com.ai.common.web.CommonService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 11. 02
 * @implSpec down service business logic.
 */
@Service
public class DownService {

	@Autowired
	DownMapper downMapper;

	/**
	 * @implNote select prod down list.
	 * @param prodDownSearchVo
	 * @return PageInfo<ProdDownVo>
	 */
	public PageInfo<ProdDownVo> selectProdDownList(ProdDownSearchVo prodDownSearchVo) {
		PageHelper.startPage(prodDownSearchVo.getPageNo(), prodDownSearchVo.getPageSize());

		PageInfo<ProdDownVo> downList = new PageInfo<ProdDownVo>(downMapper.selectProdDownList(prodDownSearchVo), prodDownSearchVo.getNavigatePages());
		int index = prodDownSearchVo.getPageNo() * prodDownSearchVo.getPageSize() - 10 + 1;
		IntStream.range(0, downList.getList().size())
		         .forEach(i -> {
		        	 downList.getList().get(i).setRowId(String.valueOf(index + i));
		         });

		return downList;
	}

	/**
	 * @implNote update prod down status.
	 * @param downList
	 * @return
	 */
	@Transactional
	public void updateProdDownStatus(List<ProdDownVo> downList) {
		downList.stream().forEach(down -> {
			CommonService.setSessionData(down);
			downMapper.updateProdDownStatus(down);
		});
	}

}
