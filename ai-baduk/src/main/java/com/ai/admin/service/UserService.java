package com.ai.admin.service;

import java.util.Objects;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ai.admin.dao.UserMapper;
import com.ai.admin.vo.UserSearchVo;
import com.ai.admin.vo.UserVo;
import com.ai.common.exception.BizException;
import com.ai.common.util.MessageUtils;
import com.ai.common.web.CommonService;
import com.ai.common.web.ExcelService;
import com.ai.common.web.FileService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author 우동하
 * @since 2022. 09. 25
 * @implSpec user service business logic.
 */
@Service
public class UserService {

	@Autowired
	UserMapper userMapper;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	FileService fileService;

	@Autowired
	ExcelService excelService;

	@Value("${upload.default.path}")
	private String UPLOAD_DEFAULT_PATH;

	@Value("${upload.excel.analyze_info.path}")
	private String ANALYZE_INFO_PATH;

	/**
	 * @implNote select user list.
	 * @param userSearchVo
	 * @return PageInfo<UserVo>
	 */
	public PageInfo<UserVo> selectUserList(UserSearchVo userSearchVo) {
		PageHelper.startPage(userSearchVo.getPageNo(), userSearchVo.getPageSize());

		PageInfo<UserVo> userList = new PageInfo<UserVo>(userMapper.selectUserList(userSearchVo), userSearchVo.getNavigatePages());
		int index = userSearchVo.getPageNo() * userSearchVo.getPageSize() - 10 + 1;
		IntStream.range(0, userList.getList().size())
		         .forEach(i -> {
		        	 userList.getList().get(i).setRowId(String.valueOf(index + i));
		         });

		return userList;
	}

	/**
	 * @implNote select user info.
	 * @param userVo
	 * @return UserVo
	 */
	public UserVo selectUserOne(UserVo userVo) {
		return userMapper.selectUserOne(userVo);
	}

	/**
	 * @implNote update user.
	 * @param userVo
	 * @return
	 */
	@Transactional
	public void updateUser(UserVo userVo) {
		CommonService.setSessionData(userVo);
		userMapper.updateUser(userVo);
	}

	/**
	 * @implNote update password.
	 * @param userVo
	 * @return
	 */
	@Transactional
	public void updatePassword(UserVo userVo) {
		final UserVo persistUser = userMapper.selectUserOne(userVo);
		// [20221016] 관리자는 기존 비밀번호 관계없이 패스워드 변경 가능하도록 수정
		if (Objects.isNull(persistUser)) {
			throw new BizException(MessageUtils.getMessage("ERROR.USER.001"));
		}
		if(!userVo.getNewPW().equals(userVo.getNewPWcheck())) {
			throw new BizException(MessageUtils.getMessage("ERROR.USER.004"));
		}
		CommonService.setSessionData(userVo);
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        userVo.setUserPw(passwordEncoder.encode(userVo.getNewPW()));
		userMapper.updatePassword(userVo);
	}

	/**
	 * @implNote delete user.
	 * @param userId
	 * @return
	 */
	@Transactional
	public void withdrawal(String userId) {
		userMapper.withdrawal(userId);
	}

}
