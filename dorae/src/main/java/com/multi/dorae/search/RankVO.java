package com.multi.dorae.search;


public class RankVO {
	
	int rank_id;
	String play_id,rank_genre,rank_area,rank_date,ranking;
	public int getRank_id() {
		return rank_id;
	}
	public void setRank_id(int rank_id) {
		this.rank_id = rank_id;
	}
	public String getPlay_id() {
		return play_id;
	}
	public void setPlay_id(String play_id) {
		this.play_id = play_id;
	}
	public String getRank_genre() {
		return rank_genre;
	}
	public void setRank_genre(String rank_genre) {
		this.rank_genre = rank_genre;
	}
	public String getRank_area() {
		return rank_area;
	}
	public void setRank_area(String rank_area) {
		this.rank_area = rank_area;
	}
	public String getRank_date() {
		return rank_date;
	}
	public void setRank_date(String rank_date) {
		this.rank_date = rank_date;
	}
	public String getRanking() {
		return ranking;
	}
	public void setRanking(String ranking) {
		this.ranking = ranking;
	}
	@Override
	public String toString() {
		return "RankVO [rank_id=" + rank_id + ", play_id=" + play_id + ", rank_genre=" + rank_genre + ", rank_area="
				+ rank_area + ", rank_date=" + rank_date + ", ranking=" + ranking + "]";
	}
	
}
