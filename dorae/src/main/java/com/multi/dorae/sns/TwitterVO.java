package com.multi.dorae.sns;

import java.util.List;

public class TwitterVO {
	private String user;
    private String screenName;
    private String text;
    private List<String> mediaUrls;
    
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getScreenName() {
		return screenName;
	}
	public void setScreenName(String screenName) {
		this.screenName = screenName;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public List<String> getMediaUrls() {
		return mediaUrls;
	}
	public void setMediaUrls(List<String> mediaUrls) {
		this.mediaUrls = mediaUrls;
	}
	@Override
	public String toString() {
		return "TwitterVO [user=" + user + ", screenName=" + screenName + ", text=" + text + ", mediaUrls=" + mediaUrls
				+ "]";
	}

	

	

}
