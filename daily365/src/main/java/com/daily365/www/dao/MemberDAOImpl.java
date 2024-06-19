package com.daily365.www.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.daily365.www.utils.SearchCriteria;
import com.daily365.www.vo.BoardVO;
import com.daily365.www.vo.CalendarVO;
import com.daily365.www.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertMember(MemberVO memberVO)throws Exception {
		sqlSession.insert("MemberMapper.insertMember",memberVO);
	}

	@Override
	public int selectIdDupChk(String userId) throws Exception {
		return sqlSession.selectOne("MemberMapper.selectIdDupChk",userId);
	}

	@Override
	public int selectLogin(MemberVO memberVO) throws Exception {
		return sqlSession.selectOne("MemberMapper.selectLogin",memberVO);
	}

	@Override
	public void updatePass(MemberVO memberVO) throws Exception {
		sqlSession.selectOne("MemberMapper.updatePass",memberVO);
	}

	@Override
	public MemberVO selectMember(String userId) throws Exception {
		return sqlSession.selectOne("MemberMapper.selectMember",userId);
	}

	@Override
	public void deleteMember(MemberVO memberVO) throws Exception {
		sqlSession.update("MemberMapper.deleteMember",memberVO);
		
	}
	
	public int selectPassChk(MemberVO memberVO)throws Exception{
		return sqlSession.selectOne("MemberMapper.selectPassChk",memberVO);
		
	}
	
	
	@Override
	public List<BoardVO> selectList(SearchCriteria scri) throws Exception {
		return sqlSession.selectList("MemberMapper.selectList",scri);
	}

	@Override
	public int totalCount(SearchCriteria scri) throws Exception {
		return sqlSession.selectOne("MemberMapper.totalCount",scri) ;
	}

	@Override
	public void insertCalendar(CalendarVO calendarVO) throws Exception {
		sqlSession.insert("MemberMapper.insertCalendar" ,calendarVO);
		
	}

	@Override
	public List<CalendarVO> selectCalendarList(CalendarVO calendarVO) throws Exception {
		return sqlSession.selectList("MemberMapper.selectCalendarList",calendarVO);
	}

	@Override
	public CalendarVO selectCalendarByIdx(int idx) throws Exception {
		return sqlSession.selectOne("MemberMapper.selectCalendarByIdx",idx);
	}

	@Override
	public void updateCalendar(CalendarVO calendarVO) throws Exception {
		sqlSession.update("MemberMapper.updateCalendar",calendarVO);
		
	}

	@Override
	public void deleteCalendar(int idx) throws Exception {
		sqlSession.update("MemberMapper.deleteCalendar",idx);
	}

	
	@Override
	public List<BoardVO> selectChart1(String userId) throws Exception {
		return sqlSession.selectList("MemberMapper.selectChart1",userId);
	}

	@Override
	public List<BoardVO> selectChart2(String userId) throws Exception {
		return sqlSession.selectList("MemberMapper.selectChart2",userId);
	}
	@Override
	public List<BoardVO> selectChart3(String userId) throws Exception {
		return sqlSession.selectList("MemberMapper.selectChart3",userId);
	}
	@Override
	public List<BoardVO> selectChart4(String uesrId) throws Exception {
		return sqlSession.selectList("MemberMapper.selectChart4",uesrId);
	}
	@Override
	public List<CalendarVO> selectChart5(String userId) throws Exception {
		return sqlSession.selectList("MemberMapper.selectChart5",userId);
	}
	@Override
	public List<BoardVO> selectChart6(String userId) throws Exception {
		return sqlSession.selectList("MemberMapper.selectChart6",userId);
	}
	
	

	
}
