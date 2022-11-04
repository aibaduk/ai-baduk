package com.ai.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.admin.vo.ProdDownSearchVo;
import com.ai.admin.vo.ProdDownVo;


/**
 * @author 우동하
 * @since 2022. 11. 02
 * @implSpec down database connection.
 */
@Mapper
public interface DownMapper {
	/**
	 * @implNote select prod down list.
	 * @param downSearchVo
	 * @return List<DownVo>
	 */
	public List<ProdDownVo> selectProdDownList(ProdDownSearchVo downSearchVo);

	/**
	 * @implNote update prod down status.
	 * @param downVo
	 * @return int
	 */
	public int updateProdDownStatus(ProdDownVo downVo);

}
