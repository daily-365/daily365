package com.daily365.www.dao;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.daily365.www.utils.SearchCriteria;
import com.daily365.www.vo.BoardLikeVO;
import com.daily365.www.vo.BoardReportVO;
import com.daily365.www.vo.BoardVO;
import com.daily365.www.vo.CalendarVO;
import com.daily365.www.vo.ReplyLikeVO;
import com.daily365.www.vo.ReplyReportVO;
import com.daily365.www.vo.ReplyVO;

public interface BoardDAO {
	
	public void insertBoard(BoardVO boardVO)throws Exception;
	public List<BoardVO>selectBoard(SearchCriteria scri)throws Exception;
	public BoardVO selectById(int bno)throws Exception;
	public void updateBoard(BoardVO boardVO)throws Exception;
	public void deleteBoard(int bno)throws Exception;
	public int totalCount(SearchCriteria scri)throws Exception;
	public void updateLike(int bno)throws Exception;
	public void updateReport(int bno)throws Exception;
	public void updateHit(int bno)throws Exception;
	public void insertLikeByUserId(BoardLikeVO boardLikeVO)throws Exception;
	public void insertReportByUserId(BoardReportVO boardReportVO)throws Exception;
	public int selectLikeByUserId(BoardLikeVO boardLikeVO)throws Exception;
	public int selectReportByUserId(BoardReportVO boardReportVO)throws Exception;
	public List<ReplyVO>selectReply(int bno)throws Exception;
	public void insertReply(ReplyVO replyVO)throws Exception;
	public void updateReply(ReplyVO replyVO)throws Exception;
	public void deleteReply(int rno)throws Exception;
	public void replyLike(int rno)throws Exception;
	public void replyReport(int rno)throws Exception;
	public void updateReplyLikeCnt(int rno)throws Exception;
	public void updateReplyReportCnt(int rno)throws Exception;
	public void insertReplyLike(ReplyLikeVO replyLikeVO)throws Exception;
	public void insertReplyReport(ReplyReportVO replyReportVO)throws Exception;
	public int selectReplyLike(ReplyLikeVO replyLikeVO)throws Exception;
	public int selectReplyReport(ReplyReportVO replyReportVO)throws Exception;
	public void insertFile(Map<String, Object> map)throws Exception;
	public List<Map<String, Object>>selectFile(int bno)throws Exception;
	public Map<String,Object> selectByFileNo(Map<String,Object>map)throws Exception;
	public void deleteFile(int fileNo)throws  Exception;
	public void deleteFileByBno(int bno)throws Exception;
	public void insertFileByBno(Map<String, Object> map)throws Exception;
	public List<BoardVO> selectExcelInfo(SearchCriteria scri)throws Exception;
	
}
