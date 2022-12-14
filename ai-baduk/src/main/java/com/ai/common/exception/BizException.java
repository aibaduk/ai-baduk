package com.ai.common.exception;

@SuppressWarnings("serial")
public class BizException extends RuntimeException {
	// 에러 코드 값을 저장하기 위한 필드를 추가 했다.
    private final String ERR_CODE;

    public BizException(String errCode, String msg) {
        super(msg);
        ERR_CODE = errCode;
    }

    public BizException(String msg) {
        this("100", msg);
    }

    public String getErrCode() {
        return ERR_CODE;
    }
}
