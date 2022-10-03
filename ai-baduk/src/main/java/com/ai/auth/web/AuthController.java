package com.ai.auth.web;

import java.util.Objects;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ai.admin.service.CodeService;
import com.ai.auth.service.AuthService;
import com.ai.auth.vo.UserVo;
import com.ai.board.service.BoardService;
import com.ai.common.exception.BizException;
import com.ai.common.util.Constants;

@Controller
public class AuthController {

	@Autowired
	private AuthService authService;

	@Autowired
	private CodeService codeService;

	@Autowired
	private BoardService boardService;

	/**
     * localhost:8080 시 login 으로 redirect
     * @return
     */
    @GetMapping
    public String root(Model model, Authentication authentication) {
    	if (!Objects.isNull(authentication)) {
    		UserVo userVo = (UserVo) authentication.getPrincipal();  //userDetail 객체를 가져옴
    		model.addAttribute("userInfo", userVo);
    	}
		model.addAttribute("noticeList", boardService.selectBoardListByExternal(Constants.BOARD_GUBUN_NOTICE, Constants.DATE_CONTROL_DAY, Constants.MAIN_BOARD_LIST_CNT));
		model.addAttribute("questionList", boardService.selectBoardListByExternal(Constants.BOARD_GUBUN_QUESTIONS, Constants.DATE_CONTROL_DAY, Constants.MAIN_BOARD_LIST_CNT));
		model.addAttribute("infoList", boardService.selectBoardListByExternal(Constants.BOARD_GUBUN_INFO, Constants.DATE_CONTROL_DAY, Constants.MAIN_BOARD_LIST_CNT));
        return "common/main";
    }

    /**
     * 로그인 폼 (현재 로그인 폼이 메인에 포함되어 있음)
     * @return
     */
    @GetMapping("/auth/login")
    public String login(Model model, Authentication authentication){
    	if (!Objects.isNull(authentication)) {
    		UserVo userVo = (UserVo) authentication.getPrincipal();  //userDetail 객체를 가져옴
    		model.addAttribute("userInfo", userVo);
    	}
    	model.addAttribute("noticeList", boardService.selectBoardListByExternal(Constants.BOARD_GUBUN_NOTICE, Constants.DATE_CONTROL_DAY, Constants.MAIN_BOARD_LIST_CNT));
    	model.addAttribute("questionList", boardService.selectBoardListByExternal(Constants.BOARD_GUBUN_QUESTIONS, Constants.DATE_CONTROL_DAY, Constants.MAIN_BOARD_LIST_CNT));
    	model.addAttribute("infoList", boardService.selectBoardListByExternal(Constants.BOARD_GUBUN_INFO, Constants.DATE_CONTROL_DAY, Constants.MAIN_BOARD_LIST_CNT));
        return "common/main";
    }

    @GetMapping("/auth/fail")
    public String temp(Model model
  		, @RequestParam(value = "error", required = false) String error
  		, @RequestParam(value = "exception", required = false) String exception
  		, RedirectAttributes redirectAttribute){
    	redirectAttribute.addFlashAttribute("error", error);
    	redirectAttribute.addFlashAttribute("exception",exception);
    	return "redirect:/";
    }

    /**
     * 회원가입 폼
     * @return
     */
    @GetMapping("/admin/signUp")
    public String signUpForm(Model model) {
    	model.addAttribute("codeCU001", codeService.selectCode("CU001"));
    	model.addAttribute("codeCU002", codeService.selectCode("CU002"));
    	model.addAttribute("codeCU003", codeService.selectCode("CU003"));
    	model.addAttribute("codeCU004", codeService.selectCode("CU004"));
    	return "admin/signUp";
    }

    /**
     * 회원가입 진행
     * @param userVo
     * @return
     * @throws BizException
     * @throws Exception
     */
    @PostMapping("/signUp")
    public String signUp(Model model, UserVo userVo) {
    	try {
    		authService.joinUser(userVo);
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
    	return Constants.JSON_VIEW;
    }

    /**
     * 행안부 주소 API 호출 예제 페이지
     * @return
     */
    @GetMapping("/admin/postcodify/default")
    public String postcodifyDefault(Model model) {
    	return "admin/postcodifyDefault";
    }

    /**
     * daum 주소 API 호출 예제 페이지
     * @return
     */
    @GetMapping("/admin/daum/default")
    public String daumpostDefault(Model model) {
    	return "admin/daumpostDefault";
    }

}
