package com.multi.dorae.admin;

// 메일 수신자 정보 객체
public class RecipientForRequest {
	
	private String address = null; // 메일 수신자 주소
	private String name = null; // 메일 수신자 이름, 필수 아님
	private String type = "R"; //수신자 유형 -> R: 수신자, C: 참조인, B: 숨은참조
	private Object parameters = null; // 필수 아님
	
	public RecipientForRequest(String address, String name, String type, Object parameters) {
		super();
		this.address = address;
		this.name = name;
		this.type = type;
		this.parameters = parameters;
	}
	
	public RecipientForRequest(String address, String name) {
		super();
		this.address = address;
		this.name = name;
	}

	@Override
	public String toString() {
		return "RecipientForRequest [address=" + address + ", name=" + name + ", type=" + type + ", parameters="
				+ parameters + "]";
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public Object getParameters() {
		return parameters;
	}

	public void setParameters(Object parameters) {
		this.parameters = parameters;
	}
	
	
	
}
