package com.multi.dorae.search;


public class StageVO {
	
	String stage_id,stage_name,stage_cnt;
	String kind,open_year,seat_cnt,tel,website,address,latitude,longitude;
	public String getStage_id() {
		return stage_id;
	}
	public void setStage_id(String stage_id) {
		this.stage_id = stage_id;
	}
	public String getStage_name() {
		return stage_name;
	}
	public void setStage_name(String stage_name) {
		this.stage_name = stage_name;
	}
	public String getStage_cnt() {
		return stage_cnt;
	}
	public void setStage_cnt(String stage_cnt) {
		this.stage_cnt = stage_cnt;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getOpen_year() {
		return open_year;
	}
	public void setOpen_year(String open_year) {
		this.open_year = open_year;
	}
	public String getSeat_cnt() {
		return seat_cnt;
	}
	public void setSeat_cnt(String seat_cnt) {
		this.seat_cnt = seat_cnt;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	@Override
	public String toString() {
		return "StageVO [stage_id=" + stage_id + ", stage_name=" + stage_name + ", stage_cnt=" + stage_cnt + ", kind="
				+ kind + ", open_year=" + open_year + ", seat_cnt=" + seat_cnt + ", tel=" + tel + ", website=" + website
				+ ", address=" + address + ", latitude=" + latitude + ", longitude=" + longitude + "]";
	}
	
	
	
	
}
