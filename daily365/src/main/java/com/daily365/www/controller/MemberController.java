package com.daily365.www.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.daily365.www.service.BoardService;
import com.daily365.www.service.MemberService;
import com.daily365.www.utils.PageMaker;
import com.daily365.www.utils.SearchCriteria;
import com.daily365.www.vo.BoardVO;
import com.daily365.www.vo.CalendarVO;
import com.daily365.www.vo.MemberVO;

@Controller
public class MemberController {

	public static Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;

	@RequestMapping(value = "/member/regist" ,method = RequestMethod.GET)
	public String getInertMember()throws Exception{
		logger.info("GET INSERT MEMBER");
		return "member/regist";
	}
	@RequestMapping(value = "/member/regist",method = RequestMethod.POST)
	public String postInsertMember(MemberVO memberVO)throws Exception{
		logger.info("POST INSERT MEMBER");
		memberService.insertMember(memberVO);
		return "/member/login";
	}
	
	@ResponseBody
	@RequestMapping(value = "/member/idDupChk", method = RequestMethod.POST)
	public boolean postIdDupChk(String userId)throws Exception{
		int result = memberService.selectIdDupChk(userId);
		if(result>0) {
			return false;
		}else {
			return true;
		}
		
	}
	
	@RequestMapping(value = "/member/login",method = RequestMethod.GET)
	public String getLoginMember()throws Exception{
		logger.info("GET MEMBER LOGIN");
		return "member/login";
	}
	
	@RequestMapping(value = "/member/login" , method =  RequestMethod.POST)
	public String postLoginMember(MemberVO memberVO,HttpSession session,RedirectAttributes rttr)throws Exception{
		logger.info("POST MEMBER LOGIN");
		int result = memberService.selectLogin(memberVO);
		if(result==1) {
			session.setAttribute("userId",memberVO.getUserId());
			session.setMaxInactiveInterval(30*60);
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("result",false);
			return "redirect:/member/login";
			
		}

	}
	@RequestMapping(value = "/member/logout" ,method = {RequestMethod.GET ,  RequestMethod.POST})
	public String postLogoutMember(HttpSession session)throws Exception{
		logger.info("MEMBER LOGOUT");
		session.invalidate();
		return "redirect:/";
	}
	
	
	
	@RequestMapping(value = "/mypage/main", method = RequestMethod.GET)
	public String getMypage(Model model,HttpSession session,CalendarVO calendarVO,@ModelAttribute SearchCriteria scri)throws Exception{
		logger.info("GET Mypage Main");
		String userId = (String)session.getAttribute("userId");
		
		scri.setWriter(userId);   //scri extend cri 에 한번더 cri extend boardVO 사용 : 
		scri.setPagePerNum(5); //5개씩 보기 (변경)

		List<BoardVO> list= memberService.selectList(scri);
		model.addAttribute("list",list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setDisplayPageNum(5); //5페이지씩 출력 (변경)
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(memberService.totalCount(scri));
		model.addAttribute("pageMaker",pageMaker);
		
		model.addAttribute("totalCnt",memberService.totalCount(scri));
		
		List<BoardVO>chart1List = memberService.selectChart1(userId);
		model.addAttribute("chart1List",chart1List);
		List<BoardVO> chart2List = memberService.selectChart2(userId);
		model.addAttribute("chart2List",chart2List);
		
		return "member/mypage/main";
		
	}
	
	
	@RequestMapping(value = "/mypage/account" ,method =  RequestMethod.GET)
	public String getMyPageAccount(HttpSession session, Model model)throws Exception{
		logger.info("GET MYPAGE");
		String userId =(String)session.getAttribute("userId");
		MemberVO memberVO = memberService.selectMember(userId);
		model.addAttribute("member",memberVO);
		return "member/mypage/account";
	}
	
	@RequestMapping(value = "/mypage/updatepass" ,method =  RequestMethod.GET)
	public String getUpdatePass()throws Exception{
		logger.info("GET UPDATEPASS");
		return "member/mypage/updatepass";
	}
	
	@ResponseBody
	@RequestMapping(value ="/mypage/updatepass" ,method =  RequestMethod.POST)
	public String postPassChk(MemberVO memberVO 
							,@RequestParam("userId")String userId
							,@RequestParam("userPass")String userPass			
							,@RequestParam("modDate")String modDate	
							,HttpSession session)throws Exception{
		logger.info("POST MYPAGE UPDATE PASSWORD");
		memberVO.setUserId(userId);
		memberVO.setUserPass(userPass);
		memberVO.setModDate(modDate);
		session.invalidate();
		 memberService.updatePass(memberVO);
		 return "PASSWORD UPDATE SUCCESS";
	}
	
	@RequestMapping(value = "/mypage/delete" ,method =  RequestMethod.GET)
	public String getDeleteMember()throws Exception{
		logger.info("GET DELETE MEMBER");
		return"member/mypage/delete";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mypage/delete",method =RequestMethod.POST )
	public String postDeleteMember(MemberVO memberVO
								,@RequestParam("userId")String userId 
								,@RequestParam("userPass")String userPass
								,HttpSession session)throws Exception{
		logger.info("POST DELETE MEMBER");
		memberVO.setUserId(userId);
		memberVO.setUserPass(userPass);
		
		memberService.deleteMember(memberVO);
		session.invalidate();
		
		return "DELETE MEMBER SUCCESS";
	}
	
	@ResponseBody
	@RequestMapping(value = "/member/passchk",method =RequestMethod.POST )
	public boolean postMemberPassChk(@RequestParam("userId")String userId, @RequestParam("userPass")String userPass,MemberVO memberVO)throws Exception{
		memberVO.setUserId(userId);
		memberVO.setUserPass(userPass);
		int result = memberService.selectPassChk(memberVO);
		if(result==1){
			return true;
		}else {
			return false;
		}
	}
	
	@RequestMapping(value = "/mypage/calendar", method = RequestMethod.GET)
	public String getCalendar(CalendarVO calendarVO,Model model,HttpSession session)throws Exception{
		logger.info("GET Calendar");
		
		calendarVO.setWriter((String)session.getAttribute("userId"));
		List<CalendarVO> calendarList = memberService.selectCalendarList(calendarVO);
		model.addAttribute("calendarList",calendarList);

		return "member/mypage/calendar";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mypage/calendar/read")
	public CalendarVO postReadCalendar(@RequestParam("idx")int idx,HttpSession session)throws Exception{
		logger.info("POST READ CALENDAR");
		CalendarVO calendarVO = memberService.selectCalendarByIdx(idx);
		return calendarVO;
	}
	
	@ResponseBody
	@RequestMapping(value = "/mypage/calendar/insert", method = RequestMethod.POST, produces = "application/text; charset=UTF-8;")
	public String postInsertCalendar(
									@RequestParam("title")String title
									,@RequestParam("content")String content
									,@RequestParam("start")String start
									,@RequestParam("end")String end
									,@RequestParam("color")String color
									,HttpSession session
									)throws Exception{
		logger.info("POST Insert Calendar");
		CalendarVO calendarVO = new CalendarVO();
		
		calendarVO.setTitle(title);
		calendarVO.setContent(content);
		calendarVO.setWriter((String)session.getAttribute("userId"));
		calendarVO.setStart(start);
		calendarVO.setEnd(end);
		calendarVO.setColor(color);
		
		memberService.insertCalendar(calendarVO);
		return "일정이 저장되었습니다.";
		
	}
	
	@ResponseBody
	@RequestMapping(value = "/mypage/calendar/update" ,method =  RequestMethod.POST,produces = "applicaiton/text; charset=UTF-8;")
	public String postUpdateCalendar(@RequestParam("idx")String idx,
									@RequestParam("title")String title,
									@RequestParam("content")String content,
									@RequestParam("start")String start,
									@RequestParam("end")String end,
									@RequestParam("color")String color,
									HttpSession session)throws Exception{
		logger.info("UPDATE CALENDAR");
		
		CalendarVO calVO = new CalendarVO();
		calVO.setIdx(Integer.parseInt(idx));
		calVO.setTitle(title);
		calVO.setContent(content);
		calVO.setStart(start);
		calVO.setEnd(end);
		calVO.setColor(color);
		
		memberService.updateCalendar(calVO);
		
		return "일정이 수정되었습니다.";
	}
	
	@ResponseBody
	@RequestMapping(value = "/mypage/calendar/delete",method = RequestMethod.POST,produces = "application/text; charset=UTF-8;")
	public String postDeleteCalendar(@RequestParam("idx")String idx)throws Exception{
		memberService.deleteCalendar(Integer.parseInt(idx));
		
		return "삭제되었습니다.";
	}

	
	@RequestMapping(value = "/mypage/statistics")
	public String getStatistic(Model model,HttpSession session)throws Exception{
		logger.info("GET STATISTICS");
		
		String userId = (String)session.getAttribute("userId");
		
		List<BoardVO> chart3List = memberService.selectChart3(userId);
		model.addAttribute("chart3List",chart3List);
		List<BoardVO> chart4List = memberService.selectChart4(userId);
		model.addAttribute("chart4List",chart4List);
		List<CalendarVO> chart5List = memberService.selectChart5(userId);
		model.addAttribute("chart5List",chart5List);
		List<BoardVO> chart6List = memberService.selectChart6(userId);
		model.addAttribute("chart6List",chart6List);
		
		return "member/mypage/statistics";
	}
}
