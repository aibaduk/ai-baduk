package com.ai.down.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.down.vo.PubProdDownSearchVo;
import com.ai.down.vo.PubProdDownVo;

/**
 * @author 우동하
 * @since 2022. 10. 27
 * @implSpec down database connection.
 */
@Mapper
public interface PubDownMapper {
	/**
	 * @implNote select prod down list.
	 * @param downSearchVo
	 * @return List<DownVo>
	 */
	public List<PubProdDownVo> selectProdDownList(PubProdDownSearchVo downSearchVo);

	/**
	 * @implNote insert prod down.
	 * @param downVo
	 * @return int
	 */
	public int insertProdDown(PubProdDownVo downVo);

	/**
	 * @implNote update prod down status.
	 * @param downVo
	 * @return int
	 */
	public int updateProdDownStatus03(PubProdDownVo downVo);

	/**
	 * @implNote update prod down status.
	 * @param downVo
	 * @return int
	 */
	public int updateProdDownStatus04(PubProdDownVo downVo);

	/**
	 * @implNote select exists.
	 * @param downVo
	 * @return boolean
	 */
	public boolean selectIsExists(PubProdDownVo downVo);

}
