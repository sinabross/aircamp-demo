package com.aircamp.controller;

import java.util.List;

import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aircamp.domain.GalleryVO;
import com.aircamp.domain.ItemThumbnailVO;
import com.aircamp.domain.MemberVO;
import com.aircamp.service.MemberService;
import com.aircamp.service.SearchService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/*")
@Log4j
@AllArgsConstructor
public class CommonController {
	
	BCryptPasswordEncoder passwordEncoder;

	private MemberService memberService;
//	@Resource(name = "searchService")
	private SearchService searchService;

	@GetMapping("/sample")
	public void sample() {
		log.info("/sample==========");

	}

	@PostMapping("/sample")
	public void sample(MemberVO vo) {
		log.info("/sample==========");
		log.info(vo);

	}

	@GetMapping("/index")
	public String index() {
		log.info("/index==========");
		return "redirect:/main";
	}
	@GetMapping("/aboutus")
	public void aboutus() {
		log.info("/aboutus==========");

	}

	@GetMapping("/")
	public String index2() {
		log.info("/index==========");
		return "redirect:/main";
	}

	@GetMapping("/main")
	public void main() {
		log.info("/main==========");
	}

	@GetMapping("/loginGet")
	public String loginForm() {
		return "/common/login";
	}

	@GetMapping("/aircampLogin")
	public void loginInput(String error, String logout, Model model) {
		log.info("error: " + error);
		log.info("logout: " + logout);
		if (error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		if (logout != null) {
			model.addAttribute("logout", "Logout!");
		}

	}

	@GetMapping("/logout")
	public void logout() {

	}

	@PostMapping("/findId")
	@ResponseBody
	public ResponseEntity<String> findId(String findName, String findPhone) {
		log.info("/findId " + findName + " " + findPhone);

		MemberVO member = new MemberVO();
		member.setM_name(findName);
		member.setM_phone(findPhone);
		String resultId = memberService.findId(member);
		return resultId == null ? new ResponseEntity<>("{\"result\":\"fail\"}", HttpStatus.OK)
				: new ResponseEntity<>("{\"result\":\"success\",\"resultId\":\"" + resultId + "\"}", HttpStatus.OK);

	}

	@PostMapping("/findPw")
	@ResponseBody
	public ResponseEntity<String> findPw(String findId, String findPhone) {
		log.info("/findPw " + findId + " " + findPhone);

		MemberVO member = new MemberVO();
		member.setM_id(findId);
		member.setM_phone(findPhone);
		String resultPw = memberService.findPw(member);
		log.info(resultPw);

		
		return resultPw == null ? new ResponseEntity<>("{\"result\":\"fail\"}", HttpStatus.OK)
				: new ResponseEntity<>("{\"result\":\"success\"}", HttpStatus.OK);

	}

	@GetMapping("/haveToLogin")
	public String haveToLoginForm() {
		return "/common/haveToLogin";
	}


	@GetMapping("/item")
	public String itemList() {
		return "/item/all";
	}


	@GetMapping(value = "/itemThumbnail", produces = MediaType.APPLICATION_PROBLEM_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<ItemThumbnailVO>> getItemThumbnail(Long i_id) {

		log.info("getItemThumbnail" + i_id);

		return new ResponseEntity<>(searchService.getItemThumbnail(i_id), HttpStatus.OK);

	}


	@GetMapping(value = "/showThumbnail")
	@ResponseBody
	public ResponseEntity<FileSystemResource> showThumbnail(@RequestParam("galleryId") String g_id) {

		log.info("showThumbnail" + g_id);

		GalleryVO g_vo = searchService.getThumnailPhoto(g_id);

		String path = g_vo.getG_path();
		String uuid = g_vo.getG_uuid();
		String filename = g_vo.getG_filename();

		FileSystemResource resource = new FileSystemResource(
				"C:\\upload\\" + path.replace("\\", "\\\\") + "\\" + uuid + "_" + filename);

		HttpHeaders headers = new HttpHeaders();

		headers.add("Content-Disposition", "attachment; filename=" + filename);

		return new ResponseEntity<FileSystemResource>(resource, headers, HttpStatus.OK);
	}

}
