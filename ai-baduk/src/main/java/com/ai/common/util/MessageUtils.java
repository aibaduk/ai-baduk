package com.ai.common.util;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.context.support.MessageSourceAccessor;
import org.springframework.stereotype.Component;

@Component
public class MessageUtils {

	@Resource
	private MessageSourceAccessor source;

	static MessageSourceAccessor messageSource;

	@PostConstruct
	private void initialize() {
		messageSource = source;
	}

	public static String getMessage(String messageCd) {
		return messageSource.getMessage(messageCd);
    }
}
