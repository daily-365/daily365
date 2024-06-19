package com.daily365.www.utils;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.databind.deser.impl.ExternalTypeHandler.Builder;

public class PageMaker extends Criteria {

	private int totalCount;
	private int maxPage;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int displayPageNum=10;
	private Criteria cri;
	
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	public Criteria getCri() {
		return cri;
	}
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	
	public int getMaxPage() {
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);
		
		maxPage=(int)(Math.ceil(totalCount)/(double)cri.getPagePerNum());
		
		if(endPage>maxPage) {
			endPage=maxPage;
			return maxPage;
		}
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	
	
	public void calcData() {
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);
		startPage =(endPage-displayPageNum)+1;
		
		int tempEndPage=(int)(Math.ceil(totalCount)/(double)cri.getPagePerNum());
		if(endPage>tempEndPage) {
			endPage=tempEndPage;
		}
		prev = startPage ==1?false:true;
		next = endPage*cri.getPagePerNum()>=totalCount?false:true;
	}
	
	public String makeQuery(int page) {
		UriComponents uriComponents =
				UriComponentsBuilder.newInstance()
									.queryParam("page",page)
//									.queryParam("pagePerNum",cri.getPagePerNum())
									.build();
		return uriComponents.toUriString();
	}
	
	
	public String makeSearch(int page) {

			UriComponents uriComponents =
					UriComponentsBuilder.newInstance()
										.queryParam("page",page)
										.queryParam("pagePerNum",cri.getPagePerNum())
										.queryParam("searchType",((SearchCriteria)cri).getSearchType())
										.queryParam("keyword",encoding(((SearchCriteria)cri).getKeyword()))
										.queryParam("startDate", ((SearchCriteria)cri).getStartDate())
										.queryParam("endDate", ((SearchCriteria)cri).getEndDate())
										.build();
		return uriComponents.toUriString();
	
	}
	
	private String encoding(String keyword) {
		if(keyword==null || keyword.trim().length()==0) {
			return "";
		}try {
			return URLEncoder.encode(keyword,"UTF-8");
		}catch(UnsupportedEncodingException e) {
			return "";
		}
	}

	
}
