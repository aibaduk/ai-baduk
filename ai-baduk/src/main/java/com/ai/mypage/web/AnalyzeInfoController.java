package com.ai.mypage.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.mypage.service.AnalyzeInfoService;
import com.ai.mypage.vo.AnalyzeInfoVo;

/**
 * @author 우동하
 * @since 2022. 08. 28
 * @implSpec 분석정보 controller view.
 */
@Controller
@RequestMapping("/mypage/analyzeInfo")
public class AnalyzeInfoController {

	@Autowired
	AnalyzeInfoService analyzeInfoService;

	/**
	 * @implNote page analyzeInfo detail Linked and select analyzeInfo.
	 * @param analyzeInfoVo
	 * @return
	 */
	@GetMapping("/detail")
	public String analyzeInfoDetail(Model model, AnalyzeInfoVo analyzeInfoVo) {
		model.addAttribute("analyzeInfoDetail", analyzeInfoService.selectAnalyzeInfoOne(analyzeInfoVo));
		return "mypage/analyzeInfo/analyzeInfoDetail";
	}

}
