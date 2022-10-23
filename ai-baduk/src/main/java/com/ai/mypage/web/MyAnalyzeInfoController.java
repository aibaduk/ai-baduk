package com.ai.mypage.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.auth.vo.UserVo;
import com.ai.common.util.Constants;
import com.ai.mypage.service.MyAnalyzeInfoService;
import com.ai.mypage.vo.MyAnalyzeInfoVo;

/**
 * @author 우동하
 * @since 2022. 08. 28
 * @implSpec 분석정보 controller view.
 */
@Controller
@RequestMapping("/mypage/analyzeInfo")
public class MyAnalyzeInfoController {

	@Autowired
	MyAnalyzeInfoService myAnalyzeInfoService;

	/**
	 * @implNote page analyzeInfo detail Linked and select analyzeInfo.
	 * @param analyzeInfoVo
	 * @return
	 */
	@GetMapping("/detail")
	public String analyzeInfoDetail(Model model, Authentication authentication, MyAnalyzeInfoVo analyzeInfoVo) {
		UserVo userVo = (UserVo) authentication.getPrincipal();
    	analyzeInfoVo.setUserId(userVo.getUserId());
		model.addAttribute("analyzeInfoIdList", myAnalyzeInfoService.analyzeInfoIdList(analyzeInfoVo));
		model.addAttribute("analyzeInfoDetail", myAnalyzeInfoService.selectAnalyzeInfoOne(analyzeInfoVo));
		model.addAttribute("userId", userVo.getUserId());
		return "mypage/myanalyzeInfo/myAnalyzeInfoDetail";
	}

	/**
	 * @implNote select analyzeInfo detail.
	 * @param analyzeInfoVo
	 * @return
	 */
	@GetMapping("/search")
	public String analyzeInfoDetail(Model model, MyAnalyzeInfoVo analyzeInfoVo) {
		try {
			model.addAttribute("analyzeInfoIdList", myAnalyzeInfoService.analyzeInfoIdList(analyzeInfoVo));
			model.addAttribute("analyzeInfoDetail", myAnalyzeInfoService.selectAnalyzeInfoOne(analyzeInfoVo));
			model.addAttribute("result", true);
		} catch (Exception e) {
			model.addAttribute("msg", e.getMessage());
		}
		return Constants.JSON_VIEW;
	}


}
