package com.ai.introduce.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author 우동하
 * @since 2022. 08. 18
 * @implSpec introduce controller view.
 */
@Controller
@RequestMapping("/introduce")
public class IntroduceController {

	/**
	 * @implNote introduce main.
	 * @param model
	 * @return
	 */
	@GetMapping("/main")
	public String noticeMain(Model model) {
		return "introduce/introduceMain";
	}

}
