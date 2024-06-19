package com.daily365.www.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;


import com.daily365.www.dao.BoardDAO;
import com.daily365.www.utils.SearchCriteria;
import com.daily365.www.vo.BoardLikeVO;
import com.daily365.www.vo.BoardReportVO;
import com.daily365.www.vo.BoardVO;
import com.daily365.www.vo.CalendarVO;
import com.daily365.www.vo.ReplyLikeVO;
import com.daily365.www.vo.ReplyReportVO;
import com.daily365.www.vo.ReplyVO;

@Service
public class BoardServiceImpl implements BoardService{


	@Autowired
	private BoardDAO boardDAO;

	@Override
	public void insertBoard(BoardVO boardVO) throws Exception {
		boardDAO.insertBoard(boardVO);
	}

	@Override
	public List<BoardVO> selectList(SearchCriteria scri) throws Exception {
		return boardDAO.selectBoard(scri);
	}
	
	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public BoardVO selectById(int bno) throws Exception {
			boardDAO.updateHit(bno);
		return boardDAO.selectById(bno);
	}

	@Override
	public void updateBoard(BoardVO boardVO) throws Exception {
		boardDAO.updateBoard(boardVO);
	}

	@Override
	public void deleteBoard(int bno) throws Exception {
		boardDAO.deleteBoard(bno);
		boardDAO.deleteFileByBno(bno);
	}

	@Override
	public int totalCount(SearchCriteria scri) throws Exception {
		return boardDAO.totalCount(scri);
	}
	
	@Override
	public void updateLike(int bno) throws Exception {
			boardDAO.updateLike(bno);
		
	}
	@Override
	public void updateReport(int bno) throws Exception {
			boardDAO.updateReport(bno);
	}
	

	@Override
	public void insertLikeByUserId(BoardLikeVO boardLikeVO) throws Exception {
		boardDAO.insertLikeByUserId(boardLikeVO);
	}

	@Override
	public void insertReportByUserId(BoardReportVO boardReportVO) throws Exception {
		boardDAO.insertReportByUserId(boardReportVO);
		
	}
	
	@Override
	public int selectLikeByUserId(BoardLikeVO boardLikeVO) throws Exception {
		return boardDAO.selectLikeByUserId(boardLikeVO);
	}

	@Override
	public int selectReportByUserId(BoardReportVO boardReportVO) throws Exception {
		return boardDAO.selectReportByUserId(boardReportVO);
	}

	@Override
	public List<ReplyVO> selectReply(int bno) throws Exception {
		return boardDAO.selectReply(bno);
	}

	@Override
	public void insertReply(ReplyVO replyVO) throws Exception {
		boardDAO.insertReply(replyVO);
	}

	@Override
	public void updateReply(ReplyVO replyVO) throws Exception {
		boardDAO.updateReply(replyVO);
		
	}

	@Override
	public void deleteReply(int rno) throws Exception {
		boardDAO.deleteReply(rno);
		
	}
	
	@Override
	public void replyLike(int rno) throws Exception {
		boardDAO.replyLike(rno);
	}
	
	@Override
	public void replyReport(int rno) throws Exception {
		boardDAO.replyReport(rno);
		
	}
	@Override
	public void insertReplyLike(ReplyLikeVO replyLikeVO) throws Exception {
		boardDAO.insertReplyLike(replyLikeVO);
	}

	@Override
	public void insertReplyReport(ReplyReportVO replyReportVO) throws Exception {
		boardDAO.insertReplyReport(replyReportVO);		
	}

	@Override
	public int selectReplyLike(ReplyLikeVO replyLikeVO) throws Exception {
		return boardDAO.selectReplyLike(replyLikeVO);
	}

	@Override
	public int selectReplyReport(ReplyReportVO replyReportVO) throws Exception {
		return boardDAO.selectReplyReport(replyReportVO);
	}

	@Override
	public void insertFile(Map<String, Object> map) throws Exception {
		boardDAO.insertFile(map);
		
	}
	@Override
	public List<Map<String, Object>> selectFile(int bno) throws Exception {
		return boardDAO.selectFile(bno);
	}

	@Override
	public Map<String, Object> selectByFileNo(Map<String, Object> map) throws Exception {
		return boardDAO.selectByFileNo(map);
	}

	@Override
	public void deleteFile(int fileNo) throws Exception {
		boardDAO.deleteFile(fileNo);
	}
	
	
	@Override
	public void insertFileByBno(Map<String, Object> map) throws Exception {
		boardDAO.insertFileByBno(map);
	}

	@Override
	public List<BoardVO> selectExcelInfo(SearchCriteria scri) throws Exception {
		return boardDAO.selectExcelInfo(scri);
	}


	

	
	
}
