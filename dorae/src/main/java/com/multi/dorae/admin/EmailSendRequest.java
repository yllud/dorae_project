package com.multi.dorae.admin;

import java.util.ArrayList;
import java.util.List;

// 메일 전송 요청 객체
public class EmailSendRequest {
	
	private int templateSid; // 템플릿 번호, 네이버 클라우드 콘솔 -> Cloud Outbound Mailer -> Manage templates 에서 관리
	private List<RecipientForRequest> recipients = new ArrayList<RecipientForRequest>(); // 수신자 목록
	private boolean individual = true;  // 개인별 혹은 일반 발송 여부, true 면 개인별 발송
	private boolean advertising = false; // 광고성 메일 여부, false 면 광고성 메일이 아님
	
	public int getTemplateSid() {
		return templateSid;
	}
	public void setTemplateSid(int templateSid) {
		this.templateSid = templateSid;
	}
	public List<RecipientForRequest> getRecipients() {
		return recipients;
	}
	public void setRecipients(List<RecipientForRequest> recipients) {
		this.recipients = recipients;
	}
	public void addRecipient(RecipientForRequest rerecipient) {
		this.recipients.add(rerecipient);
	}
	public boolean isIndividual() {
		return individual;
	}
	public void setIndividual(boolean individual) {
		this.individual = individual;
	}
	public boolean isAdvertising() {
		return advertising;
	}
	public void setAdvertising(boolean advertising) {
		this.advertising = advertising;
	}
	
	
}
