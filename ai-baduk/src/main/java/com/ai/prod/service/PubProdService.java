package com.ai.prod.service;

import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ai.prod.dao.PubProdMapper;
import com.ai.prod.vo.PubProdSearchVo;
import com.ai.prod.vo.PubProdVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 10. 24
 * @implSpec prod service business logic.
 */
@Service
public class PubProdService {

	@Autowired
	PubProdMapper pubProdMapper;

	/**
	 * @implNote select prod list.
	 * @param pubProdSearchVo
	 * @return PageInfo<PubProdVo>
	 */
	public PageInfo<PubProdVo> selectProdList(PubProdSearchVo pubProdSearchVo) {
		PageHelper.startPage(pubProdSearchVo.getPageNo(), pubProdSearchVo.getPageSize());

		PageInfo<PubProdVo> prodList = new PageInfo<PubProdVo>(pubProdMapper.selectProdList(pubProdSearchVo), pubProdSearchVo.getNavigatePages());
		int index = pubProdSearchVo.getPageNo() * pubProdSearchVo.getPageSize() - 10 + 1;
		IntStream.range(0, prodList.getList().size())
		         .forEach(i -> {
		        	 prodList.getList().get(i).setRowId(String.valueOf(index + i));
		         });

		return prodList;
	}

	/**
	 * @implNote select prod by list.
	 * @param pubProdVo
	 * @return List<PubProdVo>
	 */
	public PubProdVo selectProdOne(PubProdVo pubProdVo) {
		return pubProdMapper.selectProdOne(pubProdVo);
	}

}
