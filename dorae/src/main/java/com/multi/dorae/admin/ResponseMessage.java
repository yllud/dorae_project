package com.multi.dorae.admin;

public class ResponseMessage {
	
	private Boolean success;
	private String url;
	private String message;
	
	public Boolean getSuccess() {
		return success;
	}
	public void setSuccess(Boolean success) {
		this.success = success;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "ResponseMessage [success=" + success + ", url=" + url + ", message=" + message + "]";
	}
}
