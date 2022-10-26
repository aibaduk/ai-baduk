package com.ai.common.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ai.common.vo.FileVo;

/**
 * @author 우동하
 * @since 2022. 10. 26
 * @implSpec file database connection.
 */
@Mapper
public interface FileMapper {
	/**
	 * @implNote insert board file.
	 * @param fileVo
	 * @return
	 */
	public int insertFile(FileVo fileVo);

	/**
	 * @implNote delete board file.
	 * @param fileVo
	 * @return
	 */
	public int deleteFile(FileVo fileVo);

	/**
	 * @implNote select file.
	 * @param fileVo
	 * @return List<FileVo>
	 */
	public List<FileVo> selectFile(FileVo fileVo);
}
