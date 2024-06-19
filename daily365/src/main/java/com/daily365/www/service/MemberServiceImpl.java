package com.daily365.www.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.daily365.www.dao.BoardDAO;
import com.daily365.www.dao.MemberDAO;
import com.daily365.www.utils.SearchCriteria;
import com.daily365.www.vo.BoardVO;
import com.daily365.www.vo.CalendarVO;
import com.daily365.www.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public void insertMember(MemberVO memberVO) throws Exception {
		memberDAO.insertMember(memberVO);
		
	}

	@Override
	public int selectIdDupChk(String userId) throws Exception {
		return memberDAO.selectIdDupChk(userId);
	}

	@Override
	public int selectLogin(MemberVO memberVO) throws Exception {
		return memberDAO.selectLogin(memberVO);
	}

	@Override
	public void updatePass(MemberVO memberVO) throws Exception {
		memberDAO.updatePass(memberVO);
	}

	@Override
	public MemberVO selectMember(String userId) throws Exception {
		return memberDAO.selectMember(userId);
	}

	@Override
	public void deleteMember(MemberVO memberVO) throws Exception {
		memberDAO.deleteMember(memberVO);
		
	}

	@Override
	public int selectPassChk(MemberVO memberVO) throws Exception {
		return memberDAO.selectPassChk(memberVO);
	}
	
	
	
	
	@Override
	public List<BoardVO> selectList(SearchCriteria scri) throws Exception {
		return memberDAO.selectList(scri);
	}

	@Override
	public int totalCount(SearchCriteria scri) throws Exception {
		return memberDAO.totalCount(scri);
	}

	@Override
	public void insertCalendar(CalendarVO calendarVO) throws Exception {
		memberDAO.insertCalendar(calendarVO);		
	}

	@Override
	public List<CalendarVO> selectCalendarList(CalendarVO calendarVO) throws Exception {
		return memberDAO.selectCalendarList(calendarVO);
	}

	@Override
	public CalendarVO selectCalendarByIdx(int idx) throws Exception {
		return memberDAO.selectCalendarByIdx(idx);
	}

	@Override
	public void updateCalendar(CalendarVO calendarVO) throws Exception {
		memberDAO.updateCalendar(calendarVO);
	}

	@Override
	public void deleteCalendar(int idx) throws Exception {
		memberDAO.deleteCalendar(idx);
	}

	
	@Override
	public List<BoardVO> selectChart1(String userId) throws Exception {
		return memberDAO.selectChart1(userId);
	}
	@Override
	public List<BoardVO> selectChart2(String userId) throws Exception {
		return memberDAO.selectChart2(userId);
	}
	@Override
	public List<BoardVO> selectChart3(String userId) throws Exception {
		return memberDAO.selectChart3(userId);
	}
	@Override
	public List<BoardVO> selectChart4(String userId) throws Exception {
		return memberDAO.selectChart4(userId);
	}
	@Override
	public List<CalendarVO> selectChart5(String userId) throws Exception {
		return memberDAO.selectChart5(userId);
	}

	@Override
	public List<BoardVO> selectChart6(String userId) throws Exception {
		return memberDAO.selectChart6(userId);
	}
	
	
	

}
