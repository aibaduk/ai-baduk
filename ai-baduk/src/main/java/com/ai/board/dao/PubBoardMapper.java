package com.ai.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ai.board.vo.PubBoardSearchVo;
import com.ai.board.vo.PubBoardVo;

/**
 * @author 우동하
 * @since 2022. 08. 05
 * @implSpec board database connection.
 */
@Mapper
public interface PubBoardMapper {
	/**
	 * @implNote select board list.
	 * @param boardSearchVo
	 * @return List<BoardVo>
	 */
	public List<PubBoardVo> selectBoardList(PubBoardSearchVo boardSearchVo);

	/**
	 * @implNote select board info.
	 * @param boardVo
	 * @return BoardVo
	 */
	public PubBoardVo selectBoardOne(PubBoardVo boardVo);

	/**
	 * @implNote select board primary key.
	 * @param boardGubun
	 * @return String
	 */
	public String selectBoardId(String boardGubun);

	/**
	 * @implNote insert board.
	 * @param boardVo
	 * @return
	 */
	public int insertBoard(PubBoardVo boardVo);

	/**
	 * @implNote update board.
	 * @param boardVo
	 * @return
	 */
	public int updateBoard(PubBoardVo boardVo);

	/**
	 * @implNote delete board.
	 * @param boardVo
	 * @return
	 */
	public int deleteBoard(PubBoardVo boardVo);

	/**
	 * @implNote select board list by main.
	 * @param boardGubun
	 * @param dateControlDay
	 * @param size
	 * @return List<BoardVo>
	 */
	public List<PubBoardVo> selectBoardListByExternal(@Param("boardGubun") String boardGubun
			, @Param("dateControlDay") int dateControlDay
			, @Param("size") int size);
}
