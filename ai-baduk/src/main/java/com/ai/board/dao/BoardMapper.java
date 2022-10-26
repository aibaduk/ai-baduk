package com.ai.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.ai.board.vo.BoardSearchVo;
import com.ai.board.vo.BoardVo;

/**
 * @author 우동하
 * @since 2022. 08. 05
 * @implSpec board database connection.
 */
@Mapper
public interface BoardMapper {
	/**
	 * @implNote select board list.
	 * @param boardSearchVo
	 * @return List<BoardVo>
	 */
	public List<BoardVo> selectBoardList(BoardSearchVo boardSearchVo);

	/**
	 * @implNote select board info.
	 * @param boardVo
	 * @return BoardVo
	 */
	public BoardVo selectBoardOne(BoardVo boardVo);

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
	public int insertBoard(BoardVo boardVo);

	/**
	 * @implNote update board.
	 * @param boardVo
	 * @return
	 */
	public int updateBoard(BoardVo boardVo);

	/**
	 * @implNote delete board.
	 * @param boardVo
	 * @return
	 */
	public int deleteBoard(BoardVo boardVo);

	/**
	 * @implNote select board list by main.
	 * @param boardGubun
	 * @param dateControlDay
	 * @param size
	 * @return List<BoardVo>
	 */
	public List<BoardVo> selectBoardListByExternal(@Param("boardGubun") String boardGubun
			, @Param("dateControlDay") int dateControlDay
			, @Param("size") int size);
}
