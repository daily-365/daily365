package com.daily365.www.controller;

import java.io.File;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.sl.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.poi.xwpf.usermodel.VerticalAlign;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.daily365.www.service.BoardService;
import com.daily365.www.utils.PageMaker;
import com.daily365.www.utils.SearchCriteria;
import com.daily365.www.vo.BoardLikeVO;
import com.daily365.www.vo.BoardReportVO;
import com.daily365.www.vo.BoardVO;
import com.daily365.www.vo.CalendarVO;
import com.daily365.www.vo.ReplyLikeVO;
import com.daily365.www.vo.ReplyReportVO;
import com.daily365.www.vo.ReplyVO;


@Controller
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	private static final String uploadPath ="C:\\eclipse-workspace\\daily365\\src\\main\\webapp\\resources\\upload\\";
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping( value = "/" , method =  RequestMethod.GET)
	public String index(BoardVO boardVO,Model model,@ModelAttribute("scri")SearchCriteria scri
				)throws Exception{
		logger.info("WELCOME MAIN PAGE");
	
		List<BoardVO> list = boardService.selectList(scri);
		model.addAttribute("list",list);

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(boardService.totalCount(scri));
		model.addAttribute("pageMaker",pageMaker);
		
		return "index";
	}
	
	@RequestMapping( value = "/board/write" , method =  RequestMethod.GET)
	public String getInsertBoard()throws Exception{
		logger.info("GET BOARD WRITE");
		return "board/write";
	}	
	@RequestMapping( value = "/board/write" , method =  RequestMethod.POST)
	public String  postInsertBoard(BoardVO boardVO,Model model)throws Exception{
		logger.info("POST BOARD WRITE");
		boardService.insertBoard(boardVO);
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/board/read",method =  RequestMethod.GET)
	public String getReadBoard(Model model,@RequestParam("bno")int bno)throws Exception{
		logger.info("GET BOARD READ");
		BoardVO read = boardService.selectById(bno);
		model.addAttribute("read", read);
		
		List<Map<String, Object>> fileList = boardService.selectFile(bno);
		model.addAttribute("file",fileList);
		
		return "board/read";
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/update", method =  RequestMethod.POST,produces = "application/text; charset=UTF-8;")
	public String postUpdateBoard(@RequestParam("bno")int bno,@RequestParam("title")String title,@RequestParam("content")String content
			)throws Exception{
		
		logger.info("POST BOARD UPDATE");
		BoardVO boardVO = new BoardVO();
		boardVO.setBno(bno);
		boardVO.setTitle(title);
		boardVO.setContent(content);
		
		boardService.updateBoard(boardVO);
	
		return "수정 되었습니다.";
	}
	@ResponseBody
	@RequestMapping(value = "/board/delete", method =  RequestMethod.POST,produces = "application/text; charset=UTF-8;")
	public String postDeleteBoard(@RequestParam("bno")int bno)throws Exception{
		logger.info("POST BOARD delete");
		boardService.deleteBoard(bno);
		return "삭제 되었습니다.";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/board/like",method =  RequestMethod.POST,produces = "application/text; charset=UTF-8;")
	public String postLike(@RequestParam("bno")int bno
							,@RequestParam("userId")String userId)throws Exception{
		logger.info("POST LIKE");
	
		BoardLikeVO boardLikeVO = new BoardLikeVO();
		boardLikeVO.setBno(bno);
		boardLikeVO.setUserId(userId);
		
		int likeCnt = boardService.selectLikeByUserId(boardLikeVO);
		
		if(likeCnt>0) {
			return "추천은 한번만 가능합니다.";
		}else {
			boardService.updateLike(bno);
			boardService.insertLikeByUserId(boardLikeVO);
			return "좋아요-!!";
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/report",method =  RequestMethod.POST,produces = "application/text; charset=UTF-8;")
	public String postReport(@RequestParam("bno")int bno
							,@RequestParam("userId")String userId)throws Exception{
		logger.info("POST REPORT");

		BoardReportVO boardReportVO = new BoardReportVO();
		boardReportVO.setBno(bno);
		boardReportVO.setUserId(userId);
		
		int reportCnt = boardService.selectReportByUserId(boardReportVO);
		
		if(reportCnt>0) {
			return "신고는 한번만 가능합니다.";
		}else{
			boardService.updateReport(bno);
			boardService.insertReportByUserId(boardReportVO);
			return "신고되었습니다.";
		}
	
	}

	@RequestMapping(value ="/board/reply" ,method =  RequestMethod.GET)
	public String getReply(Model model,ReplyVO replyVO,@RequestParam("bno")int bno	)throws Exception{
		logger.info("GET REPLY");
		replyVO.setBno(bno);
		List<ReplyVO> replyList = boardService.selectReply(bno);
		model.addAttribute("replyList",replyList);
		model.addAttribute("bno",bno);
		
		return "board/reply";
	}
	
	@ResponseBody
	@RequestMapping(value="/reply/write",method = RequestMethod.POST)
	public String postReplyWrite(ReplyVO replyVO)throws Exception{
		logger.info("POST REPLY WRITE");
		boardService.insertReply(replyVO);
		return "REPLY WRITE SUCCESS";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reply/update" , method =  RequestMethod.POST)
	public String postReplyUpdate(ReplyVO replyVO)throws Exception{
		logger.info("POST REPLY UPDATE");
		boardService.updateReply(replyVO);
		return "UPDATE REPLY SUCCESS";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reply/delete",method = RequestMethod.POST)
	public String postReplyDelete(@RequestParam("rno")int rno)throws Exception{
		logger.info("POST REPLY DELETE");
		boardService.deleteReply(rno);
		return "DELETE REPLY SUCCESS";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reply/like",method = RequestMethod.POST,produces = "application/text; charset=UTF-8")
	public String postReplyLike(@RequestParam("rno")int rno,
								@RequestParam("userId")String userId,
								@RequestParam("replyLikeCancleYn")String cancleYn
								)throws Exception{
		logger.info("POST REPLY LIKE");
		boardService.replyLike(rno);
		
		ReplyLikeVO replyLikeVO = new ReplyLikeVO();
		replyLikeVO.setRno(rno);
		replyLikeVO.setUserId(userId);
		replyLikeVO.setCancleYn(cancleYn);
		
		int count = boardService.selectReplyLike(replyLikeVO);
		
		if(count>0) {
			return "추천은 한번만 가능합니다.";
		}else {
			boardService.insertReplyLike(replyLikeVO);
			return "추천-!!";
		}
	
	}
	@ResponseBody
	@RequestMapping(value = "/reply/report",method = RequestMethod.POST,produces = "application/text; charset=UTF-8")
	public String postReplyRepory(@RequestParam("rno")int rno,
									@RequestParam("userId")String userId,
									@RequestParam("replyReportCancleYn")String cancleYn
									)throws Exception{
		logger.info("POST REPLY REPORY");
		boardService.replyReport(rno);
		
		ReplyReportVO replyReportVO = new ReplyReportVO();
		replyReportVO.setRno(rno);
		replyReportVO.setUserId(userId);
		replyReportVO.setCancleYn(cancleYn);
		
		int count = boardService.selectReplyReport(replyReportVO);
		
		if(count>0) {
			return "신고는 한번만 가능합니다.";
		}else {
			boardService.insertReplyReport(replyReportVO);
			return "신고 되었습니다.";
		}
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/fileUpload", method = RequestMethod.POST)
	public String fileUpload(@RequestParam("uploadFiles") List<MultipartFile> multipartFile	, HttpServletRequest request) throws Exception{
		List<Map<String,Object>> list= new ArrayList<Map<String,Object>>();
		Map<String,Object> map = null;
		
		if(multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
			for(int i=0; i<multipartFile.size(); i++) {
				map = new HashMap<String, Object>();
				
				String originalFileName = multipartFile.get(i).getOriginalFilename();	
				String extendFileName = originalFileName.substring(originalFileName.lastIndexOf("."));
				String storedFileName = UUID.randomUUID() + extendFileName;
				
				File targetFile = new File(uploadPath + storedFileName);	
				multipartFile.get(i).transferTo(targetFile);
				
				map.put("originFileName", originalFileName);
				map.put("storedFileName", storedFileName);
				map.put("fileSize",multipartFile.get(i).getSize());
				
				list.add(map);
			}
				
			for(int i=0; i<list.size(); i++) {
				boardService.insertFile(list.get(i));
			}
		}
		return "File Upload Success";
	}
	@RequestMapping(value = "/board/fileDown",method=RequestMethod.POST)
	public void postFileDown(@RequestParam Map<String,Object> map,HttpServletResponse response)throws Exception{
		Map<String,Object> resultMap = boardService.selectByFileNo(map);
		String originFileName =(String)resultMap.get("originFileName");
		String storedFileName =(String)resultMap.get("storedFileName");
		
		byte fileByte[] =org.apache.commons.io.FileUtils.readFileToByteArray(new File(uploadPath+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("content-Disposition", "attachment; fileName=\"" +URLEncoder.encode(originFileName,"UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/fileDelete",method= RequestMethod.POST,produces = "application/text; charset=UTF-8" )
	public String postFileDelete(@RequestParam("fileNo")int fileNo)throws Exception{
		boardService.deleteFile(fileNo);
		return "삭제 되었습니다.";
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/fileUpdate", method = RequestMethod.POST,produces = "applicaiton/text; charset=UTF-8")
	public String fileUpdate(@RequestParam("uploadFiles") List<MultipartFile> multipartFile	, HttpServletRequest request
							,@RequestParam("bno")int bno) throws Exception{
		List<Map<String,Object>> list= new ArrayList<Map<String,Object>>();
		Map<String,Object> map = null;
		
		if(multipartFile.size() > 0 && !multipartFile.get(0).getOriginalFilename().equals("")) {
			for(int i=0; i<multipartFile.size(); i++) {
				map = new HashMap<String, Object>();
				
				String originalFileName = multipartFile.get(i).getOriginalFilename();	
				String extendFileName = originalFileName.substring(originalFileName.lastIndexOf("."));
				String storedFileName = UUID.randomUUID() + extendFileName;
				
				File targetFile = new File(uploadPath + storedFileName);	
				multipartFile.get(i).transferTo(targetFile);
				
				map.put("bno",bno);
				map.put("originFileName", originalFileName);
				map.put("storedFileName", storedFileName);
				map.put("fileSize",multipartFile.get(i).getSize());
				
				list.add(map);
			}
				
			for(int i=0; i<list.size(); i++) {
				boardService.insertFileByBno(list.get(i));
			}
		}
		return "파일이 저장되었습니다.";
	}
	
	@ResponseBody
	@RequestMapping(value = "/board/excelDown", method = RequestMethod.POST )
	public String poiTest(Model model, HttpServletResponse response, 
			HttpServletRequest request
			,@RequestParam("searchType")String searchType
			,@RequestParam("keyword")String keyword
			,@RequestParam("startDate")String startDate
			,@RequestParam("endDate")String endDate
			) throws Exception{
		
		SearchCriteria scri = new SearchCriteria();
		
		scri.setSearchType(searchType);
		scri.setKeyword(keyword);
		scri.setStartDate(startDate);
		scri.setEndDate(endDate);
		
		List<BoardVO> list =boardService.selectExcelInfo(scri);
		
		XSSFWorkbook wb = new XSSFWorkbook(); // 엑셀파일 객체 생성
		Sheet sheet= wb.createSheet("Sheet"); //시트 생성

		CellStyle style = wb.createCellStyle();
		Font font = wb.createFont();
		
		font.setBold(true);
		font.setFontHeight((short) (16*18));
		font.setFontName("맑은 고딕");
		
		style.setAlignment(HorizontalAlignment.CENTER);
		style.setWrapText(true);
		style.setFont(font);
		
		Row titleRow = sheet.createRow(0);
		Cell titleCell =titleRow.createCell(0);
		titleCell.setCellValue("Board Data");
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,6));
		titleCell.setCellStyle(style);
		
		//데이터 삽입하기
		int rowNum = 4; // 네번째줄이 헤더니까 그 밑에서부터 데이터 삽입
		Row dataRow = null; // for문을 돌려주기위해.
		Cell dataCell = null;
		
		Row totalCntRow = sheet.createRow(1);
		Cell totalCntCell = totalCntRow.createCell(0);
		totalCntCell.setCellValue("총 데이터 건수 : "+boardService.totalCount(scri)+"건");
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,6));
		totalCntCell.setCellStyle(style);
		
		Row headerRow = sheet.createRow(2);
		Cell  headerCell= null;
		
		//헤더
		CellStyle headerStyle = wb.createCellStyle();
		headerStyle.setFont(font);
		
		headerCell = headerRow.createCell(1);
		headerCell.setCellValue("idx");
		headerCell.setCellStyle(headerStyle);
		headerCell = headerRow.createCell(2);
		headerCell.setCellValue("bno");
		headerCell.setCellStyle(headerStyle);
		headerCell = headerRow.createCell(3);
		headerCell.setCellValue("title");
		headerCell.setCellStyle(headerStyle);
		headerCell = headerRow.createCell(4);
		headerCell.setCellValue("content");
		headerCell.setCellStyle(headerStyle);
		headerCell = headerRow.createCell(5);
		headerCell.setCellValue("writer");
		headerCell.setCellStyle(headerStyle);
		headerCell = headerRow.createCell(6);
		headerCell.setCellValue("regdate");
		headerCell.setCellStyle(headerStyle);
		headerCell = headerRow.createCell(7);
		headerCell.setCellValue("deleteYn");
		headerCell.setCellStyle(headerStyle);
		
		for(int i = 0; i<list.size(); i++) {
			dataRow = sheet.createRow(rowNum++); // for문 돌면서 행 1줄씩 추가
			
			dataCell = dataRow.createCell(1);
			dataCell.setCellValue(i+1);
			dataCell = dataRow.createCell(2);
			dataCell.setCellValue(list.get(i).getBno()); 
			dataCell  = dataRow.createCell(3);
			dataCell.setCellValue(list.get(i).getTitle()); 
			dataCell  = dataRow.createCell(4);
			dataCell.setCellValue(list.get(i).getContent()); 
			dataCell  = dataRow.createCell(5);
			dataCell.setCellValue(list.get(i).getWriter()); 
			dataCell  = dataRow.createCell(6);
			dataCell.setCellValue(list.get(i).getRegdate()); 
			dataCell  = dataRow.createCell(7);
			dataCell.setCellValue(list.get(i).getDeleteYn()); 
		}
		
		String fileName=null;
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
		String now= sdf.format(date);
	
		fileName ="ExcelFile_"+now+".xlsx";
		
		 /* 엑셀 파일 생성 */
	    response.setContentType("ms-vnd/excel");
	    response.setHeader("Content-Disposition", "attachment;filename="+fileName);
	    wb.write(response.getOutputStream());
	    
	    return "EXCEL DOWNLOAD SUCCESS";
	}
	
	
}