package com.ai.prod.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.prod.vo.PubProdSearchVo;
import com.ai.prod.vo.PubProdVo;

/**
 * @author 우동하
 * @since 2022. 10. 27
 * @implSpec prod database connection.
 */
@Mapper
public interface PubProdMapper {
	/**
	 * @implNote select prod list.
	 * @param prodSearchVo
	 * @return List<ProdVo>
	 */
	public List<PubProdVo> selectProdList(PubProdSearchVo prodSearchVo);

	/**
	 * @implNote select prod.
	 * @param prodVo
	 * @return ProdVo
	 */
	public PubProdVo selectProdOne(PubProdVo prodVo);
}
