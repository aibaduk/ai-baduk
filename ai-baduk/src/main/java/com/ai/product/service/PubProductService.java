package com.ai.product.service;

import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ai.product.dao.PubProductMapper;
import com.ai.product.vo.PubProductSearchVo;
import com.ai.product.vo.PubProductVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 10. 24
 * @implSpec product service business logic.
 */
@Service
public class PubProductService {

	@Autowired
	PubProductMapper pubProductMapper;

	/**
	 * @implNote select product list.
	 * @param pubProductSearchVo
	 * @return PageInfo<PubProductVo>
	 */
	public PageInfo<PubProductVo> selectProductList(PubProductSearchVo pubProductSearchVo) {
		PageHelper.startPage(pubProductSearchVo.getPageNo(), pubProductSearchVo.getPageSize());

		PageInfo<PubProductVo> productList = new PageInfo<PubProductVo>(pubProductMapper.selectProductList(pubProductSearchVo), pubProductSearchVo.getNavigatePages());
		int index = pubProductSearchVo.getPageNo() * pubProductSearchVo.getPageSize() - 10 + 1;
		IntStream.range(0, productList.getList().size())
		         .forEach(i -> {
		        	 productList.getList().get(i).setRowId(String.valueOf(index + i));
		         });

		return productList;
	}

	/**
	 * @implNote select product by list.
	 * @param pubProductVo
	 * @return List<PubProductVo>
	 */
	public PubProductVo selectProductOne(PubProductVo pubProductVo) {
		return pubProductMapper.selectProductOne(pubProductVo);
	}

}
