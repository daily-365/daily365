package com.daily365.www.vo;

public class BoardVO {
	private int bno;
	private String title;
	private String content;
	private String writer;
	private String regdate;
	private String moddate;
	private int likeCnt;
	private int reportCnt;
	private int hitCnt;
	private String deleteYn;
	
	//chart1
	private int modChart;
	private int delChart;
	private int replyChart;
	private int fileChart;
	
	// chart 2
	private int yearChart;
	private int monthChart;
	private int bnoChart;
	private int hitChart;
	private int likeChart;
	private int reportChart;
		
	//chart 3
	private String regTimeChart;
	private int regDateChart;
	
	//chart 4
	private int totalLikeChart;
	private int totalReportChart;
	
	
	private int rnum;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	public String getModdate() {
		return moddate;
	}
	public void setModdate(String moddate) {
		this.moddate = moddate;
	}
	public int getLikeCnt() {
		return likeCnt;
	}
	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}
	public int getReportCnt() {
		return reportCnt;
	}
	public void setReportCnt(int reportCnt) {
		this.reportCnt = reportCnt;
	}
	public int getHitCnt() {
		return hitCnt;
	}
	public void setHitCnt(int hitCnt) {
		this.hitCnt = hitCnt;
	}
	public String getDeleteYn() {
		return deleteYn;
	}
	public void setDeleteYn(String deleteYn) {
		this.deleteYn = deleteYn;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	
		
	public int getModChart() {
		return modChart;
	}
	public void setModChart(int modChart) {
		this.modChart = modChart;
	}
	public int getDelChart() {
		return delChart;
	}
	public void setDelChart(int delChart) {
		this.delChart = delChart;
	}
	public int getReplyChart() {
		return replyChart;
	}
	public void setReplyChart(int replyChart) {
		this.replyChart = replyChart;
	}
	public int getFileChart() {
		return fileChart;
	}
	public void setFileChart(int fileChart) {
		this.fileChart = fileChart;
	}
	public int getYearChart() {
		return yearChart;
	}
	public void setYearChart(int yearChart) {
		this.yearChart = yearChart;
	}
	public int getMonthChart() {
		return monthChart;
	}
	public void setMonthChart(int monthChart) {
		this.monthChart = monthChart;
	}
	public int getBnoChart() {
		return bnoChart;
	}
	public void setBnoChart(int bnoChart) {
		this.bnoChart = bnoChart;
	}
	public int getHitChart() {
		return hitChart;
	}
	public void setHitChart(int hitChart) {
		this.hitChart = hitChart;
	}
	public int getLikeChart() {
		return likeChart;
	}
	public void setLikeChart(int likeChart) {
		this.likeChart = likeChart;
	}
	public int getReportChart() {
		return reportChart;
	}
	public void setReportChart(int reportChart) {
		this.reportChart = reportChart;
	}
	public String getRegTimeChart() {
		return regTimeChart;
	}
	public void setRegTimeChart(String regTimeChart) {
		this.regTimeChart = regTimeChart;
	}
	public int getRegDateChart() {
		return regDateChart;
	}
	public void setRegDateChart(int regDateChart) {
		this.regDateChart = regDateChart;
	}
	public int getTotalLikeChart() {
		return totalLikeChart;
	}
	public void setTotalLikeChart(int totalLikeChart) {
		this.totalLikeChart = totalLikeChart;
	}
	public int getTotalReportChart() {
		return totalReportChart;
	}
	public void setTotalReportChart(int totalReportChart) {
		this.totalReportChart = totalReportChart;
	}
	
}
