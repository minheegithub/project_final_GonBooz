package com.gb.wn;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gb.wn.main.Service.BoardService;
import com.gb.wn.main.Service.ReplayService;
import com.gb.wn.main.board.boardVO.BoardVO;
import com.gb.wn.main.board.boardVO.LikeVO;
import com.gb.wn.main.board.boardVO.PageMaker;
import com.gb.wn.main.board.boardVO.ReplyVO;
import com.gb.wn.main.board.boardVO.SearchCriteria;
import com.gb.wn.main.member.memberVO.MemberVO;

/*
 by최민희,웹 요청과 응답을 처리함
 @RequestMapping 어노테이션을 @Controller 어노테이션 밑에서만 사용할 수 있다. 
 @Component 기능이 포함되어 있다.(빈객체생성)
 
 */
@Controller
public class BoardController {
	/*
	by최민희, @Resource(name = 이름)과 같이 특정 이름을 지정하면 필드명이 아닌 지정한 이름의 빈을 찾아 자동 주입한다.
	지정한 이름의 컴포넌트를 자동주입하였다.
	이름으로 연결 안되면 타입
	*/
	@Resource(name="boardService")
	private BoardService boardkaja;
	
	@Resource(name="replyService")
	private ReplayService replykaja;

	
	/*
	 by최민희,
	 RequestMapping애노테이션은 URL매핑을 위해 필요하다. /***로 요청을 받으면 메소드를 실행하고
	 servlet-context.xml의 viewResolver가 나머지 경로를 붙여주어 뷰페이지를 사용자에게 보여준다.
	 
	 model객체
	 Controller에서 생성된 데이터를 View로 전달할때 사용하는 객체
	 Servlet의 request.setAttribute()와 유사한 역할
	 addAttribute("키","값") 메소드를 사용하여 절달할 데이터 세팅 
	 
	 @ModelAttribute 
	 강제로 전달받은 파라미터를 자동으로 Model객체에 담아서 Veiwe단으로 전달하도록 할때 필요한 어노테이션
	 */
	
	//글쓰기 페이지로 가기
	@RequestMapping(value="board/boardInsert.do")
	public String boardIsert(@ModelAttribute("boardVO") BoardVO boardVO){
		System.out.println("글쓰기 페이지 bno"+boardVO.toString());
		return "board/boardWrite";
	}
	
	/*
	 by최민희,
	 context파일에 multipartResolver를 bean에 등록 
	 이후 컨트롤러에서 요청을 받아 다음과 같이 MultipartHttpServeltRequest객체를 사용할 수 있다.
	 */
	//게시판 글쓰기
	@RequestMapping(value="board/boardWrite.do", method = RequestMethod.POST)
	public String boardWrite(BoardVO boardVO,  MultipartHttpServletRequest mpRequest, Model model) throws Exception {
		System.out.println(boardVO.getGongzi());
		if(boardVO.getGongzi().equals("y")) {
			String gzTitle = "[공지] "+boardVO.getTitle();
			boardVO.setTitle(gzTitle);
			boardkaja.gongziWrite(boardVO,mpRequest);
		}else {
			boardkaja.boardWrite(boardVO, mpRequest);
		}
		
		model.addAttribute("board_name", boardVO.getB_name());
		return "redirect:/board/boardList.do";
	}
	
	//게시판 글 목록
	@RequestMapping(value="board/boardList.do", method = RequestMethod.GET)
	public String boardList(Model model, @ModelAttribute("scri") SearchCriteria scri) throws Exception {
		System.out.println(scri.toString());
		/*by최민희, SearchCriteria [board_name=gb, searchType=w, keyword=spring](Criteria클래스의 자식)
		searchType = t:글제목 c:글내용 w:글쓴이 tc:글제목+내용
		검색타입과 검색 키워드를 파라미터로 가지고서 list목록을 가져온다.
		검색 결과를 창으로 보낸다.*/
		
		//by최민희, Criteria클래스에서에서 이미 setPage되었다. (SearchCritera 커멘드객체를 통해서)
		model.addAttribute("board_name", scri.getBoard_name());
		model.addAttribute("gongzi", boardkaja.listGongzi());
		model.addAttribute("boardList", boardkaja.boardList(scri));
		
		PageMaker pageMaker  = new PageMaker();
		
		pageMaker.setCri(scri);
		//by최민희,개시글 총 갯수 listCount()
		pageMaker.setTotalCount(boardkaja.listCount(scri));
		
		model.addAttribute("pageMaker", pageMaker);
		//by최민희, PageMaker클래스로 얻은값 [totalCount=40, startPage=1, endPage=4, prev=false, next=false, displayPageNum=10, cri=SearchCriteria [board_name=gb, searchType=w, keyword=spring]]
		
		return "board/boardList";
	}
	
	
	// 게시판 조회
	@RequestMapping(value="board/boardView.do", method = RequestMethod.GET)
	public String boardView(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri , Model model) throws Exception {
//		by최민희, SearchCriteria를 Controller에서 달고 다녀야 목록으로 돌아가더라도 검색한 정보를 유지할 수 있다.
		String view = "";
		if(boardVO.getGongzi().equals("n")) {
			model.addAttribute("boardView", boardkaja.boardView(boardVO));

			List<ReplyVO> replyList = replykaja.readReply(boardVO);
			model.addAttribute("replyList", replyList);
			
			Map<String, Object> fileList = boardkaja.selectFileList(boardVO);
			model.addAttribute("file", fileList);
			
			view = "board/boardView";
		}else {
			model.addAttribute("gzView", boardkaja.gongziView(boardVO));
			
			view = "board/gongziView";
		}
		
		model.addAttribute("board_name", boardVO.getB_name());
		model.addAttribute("gongzi", boardVO.getGongzi());
		return view;
	}
	
	@ResponseBody
	@RequestMapping(value="board/board_like.do", method = RequestMethod.POST)
	public int board_like(LikeVO likeVO) throws Exception {
		System.out.println(likeVO.toString());
		
		int result = boardkaja.findlike(likeVO);
		System.out.println(result);
		if(result == 0) {
			boardkaja.likeInsert(likeVO);
		}
		return result;
	}
	
	//게시판 삭제
	@RequestMapping(value="board/boardDelete.do", method = RequestMethod.POST)
	public String boardDelete(BoardVO boardVO, @ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		System.out.println("공지글 여부"+boardVO.toString());
		if(boardVO.getGongzi().equals("n")){
			
			boardkaja.boardDelete(boardVO);
		}else {
			boardkaja.gzDelete(boardVO);
		}
		
		scri.setBoard_name(boardVO.getB_name());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		rttr.addAttribute("board_name", scri.getBoard_name());
		return "redirect:/board/boardList.do";
	}
	
	//댓글 작성
	@RequestMapping(value="board/replyWrite.do", method = RequestMethod.POST)
	public String replyWrite(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr, MemberVO membervo) throws Exception {
		
		replykaja.writeReply(vo);
		
		rttr.addAttribute("userid", membervo.getUserid());
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("b_name", vo.getRb_name());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/boardView.do";
	}
	
	//댓글 수정 GET
	@RequestMapping(value="board/replyUpdateView.do", method = RequestMethod.GET)
	public String replyUpdateView(ReplyVO vo, SearchCriteria scri ,Model model) throws Exception {

		model.addAttribute("replyUpdate", replykaja.selectReply(vo));
		model.addAttribute("scri", scri);
		model.addAttribute("board_name", vo.getRb_name());
		return "board/replyUpdateView";
	}
	
	//댓글 수정 POST
	@RequestMapping(value="/board/replyUpdate.do", method = RequestMethod.POST)
	public String replyUpdate(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		
		replykaja.updateReply(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("b_name", vo.getRb_name());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/boardView.do";
	}
	
	//댓글 삭제 GET
	@RequestMapping(value="/board/replyDeleteView.do", method = RequestMethod.GET)
	public String replyDeleteView(ReplyVO vo, SearchCriteria scri, Model model) throws Exception {
		
		model.addAttribute("replyDelete", replykaja.selectReply(vo));
		model.addAttribute("scri", scri);
		model.addAttribute("board_name", vo.getRb_name());
		return "board/replyDeleteView";
	}
	
	//댓글 삭제
	@RequestMapping(value="/board/replyDelete.do", method = RequestMethod.POST)
	public String replyDelete(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		replykaja.deleteReply(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("b_name", vo.getRb_name());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/boardView.do";
	}
	
	@RequestMapping(value="/board/fileDown.do")
	public void fileDown(@RequestParam HashMap<String, Object> map, HttpServletResponse response) throws Exception{
	/*	
		by최민희
		map{bno=1, b_name=c17, page=1, perPageNum=10, searchType=, keyword=, file_no=1}
		파라미터 7개를 한꺼번에 보냈다.map.size() -- >7
	*/	
		HashMap<String, Object> resultMap = boardkaja.selectFileInfo(map);
		String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
		String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
		
		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\gb\\file\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
		
	}



	
}
