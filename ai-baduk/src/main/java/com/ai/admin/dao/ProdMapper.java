package com.ai.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.admin.vo.ProdSearchVo;
import com.ai.admin.vo.ProdVo;

/**
 * @author 우동하
 * @since 2022. 10. 24
 * @implSpec prod database connection.
 */
@Mapper
public interface ProdMapper {
	/**
	 * @implNote select prod list.
	 * @param prodSearchVo
	 * @return List<ProdVo>
	 */
	public List<ProdVo> selectProdList(ProdSearchVo prodSearchVo);

	/**
	 * @implNote select prod.
	 * @param prodVo
	 * @return ProdVo
	 */
	public ProdVo selectProdOne(ProdVo prodVo);


	/**
	 * @implNote insert prod.
	 * @param prodVo
	 * @return int
	 */
	public int insertProd(ProdVo prodVo);

	/**
	 * @implNote update prod.
	 * @param prodVo
	 * @return int
	 */
	public int updateProd(ProdVo prodVo);

	/**
	 * @implNote select prodId.
	 * @param prodClCd
	 * @return String
	 */
	public String selectProdId(String prodClCd);

}
