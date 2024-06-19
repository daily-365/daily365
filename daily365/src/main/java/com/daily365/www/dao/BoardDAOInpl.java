package com.daily365.www.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.daily365.www.utils.SearchCriteria;
import com.daily365.www.vo.BoardLikeVO;
import com.daily365.www.vo.BoardReportVO;
import com.daily365.www.vo.BoardVO;
import com.daily365.www.vo.CalendarVO;
import com.daily365.www.vo.ReplyLikeVO;
import com.daily365.www.vo.ReplyReportVO;
import com.daily365.www.vo.ReplyVO;

@Repository
public class BoardDAOInpl implements BoardDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertBoard(BoardVO boardVO) throws Exception {
		sqlSession.insert("BoardMapper.insertBoard",boardVO);
	}

	@Override
	public List<BoardVO> selectBoard(SearchCriteria scri) throws Exception {
		return sqlSession.selectList("BoardMapper.selectList",scri);
	}

	@Override
	public BoardVO selectById(int bno) throws Exception {
		return sqlSession.selectOne("BoardMapper.selectById",bno);
	}

	@Override
	public void updateBoard(BoardVO boardVO) throws Exception {
		sqlSession.update("BoardMapper.updateBoard", boardVO);
		
	}

	@Override
	public void deleteBoard(int bno) throws Exception {
		sqlSession.update("BoardMapper.deleteBoard",bno);
		
	}

	@Override
	public int totalCount(SearchCriteria scri) throws Exception {
		return sqlSession.selectOne("BoardMapper.totalCount",scri);
	}

	@Override
	public void updateLike(int bno) throws Exception {
		 sqlSession.update("BoardMapper.updateLike",bno);
	}

	@Override
	public void updateReport(int bno) throws Exception {
		sqlSession.update("BoardMapper.updateReport",bno);
	}

	@Override
	public void updateHit(int bno) throws Exception {
		sqlSession.update("BoardMapper.updateHit",bno);
	}
	
	@Override
	public void insertLikeByUserId(BoardLikeVO boardLikeVO) throws Exception {
		sqlSession.update("BoardMapper.insertLikeByuserId",boardLikeVO);
	}

	@Override
	public void insertReportByUserId(BoardReportVO boardReportVO) throws Exception {
		sqlSession.update("BoardMapper.insertReportByuserId",boardReportVO);
		
	}

	@Override
	public int selectLikeByUserId(BoardLikeVO boardLikeVO) throws Exception {
		return sqlSession.selectOne("BoardMapper.selectLikeByUserId",boardLikeVO);
	}

	@Override
	public int selectReportByUserId(BoardReportVO boardReportVO) throws Exception {
		return sqlSession.selectOne("BoardMapper.selectReportByUserId",boardReportVO);
	}


	@Override
	public List<ReplyVO> selectReply(int bno) throws Exception {
		return sqlSession.selectList("BoardMapper.selectReply",bno);
	}

	@Override
	public void insertReply(ReplyVO replyVO) throws Exception {
		sqlSession.insert("BoardMapper.insertReply",replyVO);
	}

	@Override
	public void updateReply(ReplyVO replyVO) throws Exception {
		sqlSession.update("BoardMapper.updateReply",replyVO);
		
	}

	@Override
	public void deleteReply(int rno) throws Exception {
		sqlSession.update("BoardMapper.deleteReply",rno);
	}

	@Override
	public void replyLike(int rno) throws Exception {
		sqlSession.update("BoardMapper.updateReplyLike",rno);
	}

	@Override
	public void replyReport(int rno) throws Exception {
		sqlSession.update("BoardMapper.updateReplyReport",rno);
		
	}
	
	
	@Override
	public void updateReplyLikeCnt(int rno) throws Exception {
		sqlSession.update("BoardMapper.updateReplyLikeCnt",rno);
	}

	@Override
	public void updateReplyReportCnt(int rno) throws Exception {
		sqlSession.update("BoardMapper.updateReplyReportCnt",rno);
	}

	@Override
	public void insertReplyLike(ReplyLikeVO replyLikeVO) throws Exception {
		sqlSession.insert("BoardMapper.insertReplyLike",replyLikeVO);
	}

	@Override
	public void insertReplyReport(ReplyReportVO replyReportVO) throws Exception {
		sqlSession.insert("BoardMapper.insertReplyReport",replyReportVO);
	}
	
	
	@Override
	public int selectReplyLike(ReplyLikeVO replyLikeVO) throws Exception {
		return sqlSession.selectOne("BoardMapper.selectReplyLike",replyLikeVO);
	}

	@Override
	public int selectReplyReport(ReplyReportVO replyReportVO) throws Exception {
		return sqlSession.selectOne("BoardMapper.selectReplyReport",replyReportVO);
	}

	@Override
	public void insertFile(Map<String, Object> map) throws Exception {
		sqlSession.insert("BoardMapper.insertFile",map);
	}

	@Override
	public List<Map<String, Object>> selectFile(int bno) throws Exception {
		return sqlSession.selectList("BoardMapper.selectFile",bno);
	}

	@Override
	public Map<String, Object> selectByFileNo(Map<String, Object> map) throws Exception {
		return sqlSession.selectOne("BoardMapper.selectByFileNo",map);
	}

	@Override
	public void deleteFile(int fileNo) throws Exception {
		sqlSession.update("BoardMapper.deleteFile",fileNo);
	}
	
	@Override
	public void deleteFileByBno(int bno) throws Exception {
		sqlSession.update("BoardMapper.deleteFileByBno",bno);
	}
	
	@Override
	public void insertFileByBno(Map<String, Object> map) throws Exception {
		sqlSession.insert("BoardMapper.insertFileByBno",map);
		
	}

	@Override
	public List<BoardVO> selectExcelInfo(SearchCriteria scri) throws Exception {
		return sqlSession.selectList("BoardMapper.selectExcelInfo",scri);
	}


	

	
}
