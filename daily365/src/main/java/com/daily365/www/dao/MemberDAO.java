package com.daily365.www.dao;

import java.io.File;
import java.util.List;
import java.util.Map;

import com.daily365.www.utils.SearchCriteria;
import com.daily365.www.vo.BoardVO;
import com.daily365.www.vo.CalendarVO;
import com.daily365.www.vo.MemberVO;

public interface MemberDAO {

	public void insertMember(MemberVO memberVO)throws Exception;
	public int selectIdDupChk(String userId)throws Exception;
	public int selectLogin(MemberVO memberVO)throws Exception;
	public MemberVO selectMember(String userId)throws Exception;
	public void updatePass(MemberVO memberVO)throws Exception;
	public void deleteMember(MemberVO memberVO)throws Exception;
	public int selectPassChk(MemberVO memberVO)throws Exception;
	public void insertCalendar(CalendarVO calendarVO)throws Exception;
	public List<CalendarVO> selectCalendarList(CalendarVO calendarVO)throws Exception;
	public CalendarVO selectCalendarByIdx(int idx)throws Exception;
	public void updateCalendar(CalendarVO calendarVO)throws Exception;
	public void deleteCalendar(int idx)throws Exception;
	public List<BoardVO> selectList(SearchCriteria scri)throws Exception;
	public int totalCount(SearchCriteria scri)throws Exception;
	public List<BoardVO> selectChart1(String userId)throws Exception;
	public List<BoardVO> selectChart2(String userId)throws Exception;
	public List<BoardVO> selectChart3(String userId)throws Exception;
	public List<BoardVO> selectChart4(String uesrId)throws Exception;
	public List<CalendarVO> selectChart5(String userId)throws Exception;
	public List<BoardVO> selectChart6(String userId)throws Exception;

}
