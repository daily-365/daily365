package com.daily365.www.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.daily365.www.vo.BoardVO;

public class Crawling {

	public static void main(String[] args) throws Exception{
		
		
		String articleId = "088";     //신문사 ID
		int endPid = 882000;   //PID
		
		int startPid = endPid-100;

		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>(); 
		Map<String ,Object> listMap = null;
		
		for(int i=startPid; i<endPid; i++) {
			listMap = new HashedMap<String, Object>();
			
			Document doc = Jsoup.connect("https://n.news.naver.com/mnews/article/"+articleId+"/"+"0000"+""+i+"").get();
			
			String site = "naver";  //사이트
			Elements el1 = doc.select("img.media_end_head_top_logo_img");//언론사
			Elements el2  = doc.select("li.Nlist_item._LNB_ITEM.is_active") ; //분류
			Elements el3  = doc.select("#title_area"); //제목
			Elements el4  = doc.select("#dic_area"); //내용
			Elements el5 = doc.select(".media_end_head_journalist_name"); //작성자
			Elements el6 = doc.select("#img1"); //이미지
			Elements el7  = doc.select(".media_end_head_info_datestamp_time"); //작성일 
			Elements el8  = doc.select(".media_end_head_info_datestamp_time"); //수정일
				
				listMap.put("site",site);
					
				for(Element newsPaper : el1) {
					listMap.put("newspaper",newsPaper.attr("title"));
				}
				for(Element category : el2) {
					listMap.put("category",category.text());
				}
				for(Element title : el3) {
					listMap.put("title",title.text());
				}
				for(Element content : el4) {
					listMap.put("content", content.text());
				}
				for(Element writer : el5) {
					listMap.put("writer", writer.text());
				}
				for(Element img : el6) {
					listMap.put("img", img.attr("data-src"));
				}
				for(Element regDate : el7) {
					listMap.put("regDate", regDate.attr("data-date-time"));
				}
				for(Element modDate : el8) {
					listMap.put("modDate", modDate.attr("data-modify-date-time"));
				}
				list.add(listMap);
			}
			for(int i=0; i<list.size(); i++) {
				System.out.println(list.get(i).toString());
			}
		
		}
	}
