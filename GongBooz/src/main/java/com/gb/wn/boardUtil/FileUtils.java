package com.gb.wn.boardUtil;

import java.io.File;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gb.wn.main.board.boardVO.BoardVO;
/*by최민희, 
@Compoment는 <Bean class=“…”/>와 동일한 표현이다. 빈을 등록하는 것이다.
boardServiceInmple.java에서 @Resource로 자동주입하였다.
@Resource(name = 이름)과 같이 특정 이름을 지정하면 필드명이 아닌 지정한 이름의 빈을 찾아 자동 주입한다.
*/
@Component("fileUtils")
public class FileUtils {
	
private static final String filePath = "C:\\gb\\file\\"; // 파일이 저장될 위치
	
	public Map<String, Object> parseInsertFileInfo(BoardVO boardVO, 
			MultipartHttpServletRequest mpRequest) throws Exception{
		
	/*	Iterator은 데이터들의 집합체에서 컬렉션으로부터 정보를 얻어올 수 있는 인터페이스입니다.
		List나 배열은 순차적으로 데이터의 접근이 가능하지만, Map등의 클래스들은 순차적으로 접근할 수가 없습니다.
		Iterator을 이용하여 Map에 있는 데이터들을 while문을 이용하여 순차적으로 접근합니다.*/
		
		Iterator<String> iterator = mpRequest.getFileNames();
		
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		
//		List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
		Map<String, Object> listMap = null;
		
		int bno = boardVO.getBno();
		
		File file = new File(filePath);
		if(file.exists() == false) {
			file.mkdirs();
		}
		
		//by최민희,파일이 넘어오지 않아도 HashMap객체가 생성되도록 if바깥으로 위치를 바꾸었다.(null값을 반환하도록)
		listMap = new HashMap<String, Object>();
//		while(iterator.hasNext()) {//by최민희 다중 파일 업로드가 아니기때문에 while문은 필요 없다. 따라서 ArrayList에 반환할 필요가 없다.
		multipartFile = mpRequest.getFile(iterator.next());
		if(multipartFile.isEmpty() == false) {
			originalFileName = multipartFile.getOriginalFilename();
			originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
			storedFileName = getRandomString() + originalFileExtension;
			//by최민희, 지정된 경로로 파일 저장(파일 다운로드할때 읽어올 장소이다.)
			file = new File(filePath + storedFileName);
			multipartFile.transferTo(file);
			
			listMap.put("bno", bno);
			listMap.put("org_file_name", originalFileName);
			listMap.put("stored_file_name", storedFileName);
			listMap.put("file_size", multipartFile.getSize());
			listMap.put("b_name", boardVO.getB_name());
//				list.add(listMap);
		}
//		}
		return listMap;
	}
	
	
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}
