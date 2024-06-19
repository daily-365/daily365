package com.daily365.www.utils;

import com.daily365.www.vo.BoardVO;

public class Criteria extends BoardVO {
	public int page;
	public int pagePerNum;
	public int startRow;
	public int endRow;
	
	public Criteria() {
		this.page=1;
		this.pagePerNum=10;
		
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		if(page<0) {
			this.page=1;
			return;
		}
		this.page = page;
	}
	public int getPagePerNum() {
		return pagePerNum;
	}
	public void setPagePerNum(int pagePerNum) {
		if(pagePerNum<=0||pagePerNum>100) {
			this.pagePerNum=10;
			return;
		}
		
		this.pagePerNum = pagePerNum;
	}
	
	public int getStartPage() {
		return (this.page-1)*pagePerNum;
	}
	
	public int getStartRow() {
		startRow = ((page-1)*pagePerNum)+1;
		return startRow;
	}
	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}
	public int getEndRow() {
		endRow = startRow+pagePerNum-1;
		return endRow;
	}
	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", pagePerNum=" + pagePerNum + ", startRow=" + startRow + ", endRow=" + endRow
				+ "]";
	}
	
	

}
