package com.ai.mypage.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String analyzeInfoDetail(Model model, MyAnalyzeInfoVo analyzeInfoVo) {
		model.addAttribute("analyzeInfoDetail", myAnalyzeInfoService.selectAnalyzeInfoOne(analyzeInfoVo));
		return "mypage/myanalyzeInfo/myAnalyzeInfoDetail";
	}

}
