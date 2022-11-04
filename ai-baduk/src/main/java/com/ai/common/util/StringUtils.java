package com.ai.common.util;

import org.apache.poi.util.StringUtil;

public class StringUtils {

	public static String concat(Object... array) {
		return StringUtil.join("|", array);
	}
}
