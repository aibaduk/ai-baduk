package com.ai.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.admin.vo.ProductSearchVo;
import com.ai.admin.vo.ProductVo;

/**
 * @author 우동하
 * @since 2022. 10. 24
 * @implSpec product database connection.
 */
@Mapper
public interface ProductMapper {
	/**
	 * @implNote select product list.
	 * @param productSearchVo
	 * @return List<ProductVo>
	 */
	public List<ProductVo> selectProductList(ProductSearchVo productSearchVo);

	/**
	 * @implNote select product.
	 * @param productVo
	 * @return ProductVo
	 */
	public ProductVo selectProductOne(ProductVo productVo);


	/**
	 * @implNote insert product.
	 * @param productVo
	 * @return int
	 */
	public int insertProduct(ProductVo productVo);

	/**
	 * @implNote update product.
	 * @param productVo
	 * @return int
	 */
	public int updateProduct(ProductVo productVo);

	/**
	 * @implNote select prodId.
	 * @param prodClCd
	 * @return String
	 */
	public String selectProdId(String prodClCd);

}
