package com.multi.dorae.search;

import java.sql.Date;

public class PlayVO {
	int rnum;
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	String play_id,stage_id,play_name;
	Date play_start,play_end;
	String stage_name,casting,crew,runtime,play_age,enterprise,price,poster,content,genre_name,state,openrun,image,play_time;
	public String getPlay_id() {
		return play_id;
	}
	public void setPlay_id(String play_id) {
		this.play_id = play_id;
	}
	public String getStage_id() {
		return stage_id;
	}
	public void setStage_id(String stage_id) {
		this.stage_id = stage_id;
	}
	public String getPlay_name() {
		return play_name;
	}
	public void setPlay_name(String play_name) {
		this.play_name = play_name;
	}
	public Date getPlay_start() {
		return play_start;
	}
	public void setPlay_start(Date play_start) {
		this.play_start = play_start;
	}
	public Date getPlay_end() {
		return play_end;
	}
	public void setPlay_end(Date play_end) {
		this.play_end = play_end;
	}
	public String getStage_name() {
		return stage_name;
	}
	public void setStage_name(String stage_name) {
		this.stage_name = stage_name;
	}
	public String getCasting() {
		return casting;
	}
	public void setCasting(String casting) {
		this.casting = casting;
	}
	public String getCrew() {
		return crew;
	}
	public void setCrew(String crew) {
		this.crew = crew;
	}
	public String getRuntime() {
		return runtime;
	}
	public void setRuntime(String runtime) {
		this.runtime = runtime;
	}
	public String getPlay_age() {
		return play_age;
	}
	public void setPlay_age(String play_age) {
		this.play_age = play_age;
	}
	public String getEnterprise() {
		return enterprise;
	}
	public void setEnterprise(String enterprise) {
		this.enterprise = enterprise;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getPoster() {
		return poster;
	}
	public void setPoster(String poster) {
		this.poster = poster;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getGenre_name() {
		return genre_name;
	}
	public void setGenre_name(String genre_name) {
		this.genre_name = genre_name;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getOpenrun() {
		return openrun;
	}
	public void setOpenrun(String openrun) {
		this.openrun = openrun;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getPlay_time() {
		return play_time;
	}
	public void setPlay_time(String play_time) {
		this.play_time = play_time;
	}
	@Override
	public String toString() {
		return "PlayVO [play_id=" + play_id + ", stage_id=" + stage_id + ", play_name=" + play_name + ", play_start="
				+ play_start + ", play_end=" + play_end + ", stage_name=" + stage_name + ", casting=" + casting
				+ ", crew=" + crew + ", runtime=" + runtime + ", play_age=" + play_age + ", enterprise=" + enterprise
				+ ", price=" + price + ", poster=" + poster + ", content=" + content + ", genre_name=" + genre_name
				+ ", state=" + state + ", openrun=" + openrun + ", image=" + image + ", play_time=" + play_time + "]";
	}


	
	
}
