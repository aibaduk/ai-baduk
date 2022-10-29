package com.ai.product.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.product.vo.PubProductSearchVo;
import com.ai.product.vo.PubProductVo;

/**
 * @author 우동하
 * @since 2022. 10. 27
 * @implSpec product database connection.
 */
@Mapper
public interface PubProductMapper {
	/**
	 * @implNote select product list.
	 * @param productSearchVo
	 * @return List<ProductVo>
	 */
	public List<PubProductVo> selectProductList(PubProductSearchVo productSearchVo);

	/**
	 * @implNote select product.
	 * @param productVo
	 * @return ProductVo
	 */
	public PubProductVo selectProductOne(PubProductVo productVo);
}
