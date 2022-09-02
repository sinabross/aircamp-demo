package com.aircamp.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PostAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aircamp.domain.MemberVO;
import com.aircamp.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/member")
@Log4j
@AllArgsConstructor
public class MemberController {

	private MemberService service;

	@PostAuthorize("isAnonymous()")
	@GetMapping("/joinagree")
	public void joinagree() {
		log.info("/joinagree =========");
	}

	@PostAuthorize("isAnonymous()")
	@GetMapping("/join")
	public void join() {
		log.info("/join ==========");
	}

	@PostMapping("/join")
	public String memberjoin(MemberVO member) {

		log.info("memberjoin:" + member);

		// tbl_member테이블 insert할 때 tbl_member_auth에 권한도 insert

		service.memberjoin(member);

		return "redirect:/main";

	}

	@GetMapping(value = "/idcheck", produces = "text/json; charset=UTF-8")
	@ResponseBody
	public ResponseEntity<String> idcheck(String id) {

		log.info("idcheck...." + id);

		Integer cnt = service.idcheck(id);

		log.info(cnt);

		// "{\"cnt\":\""+cnt+"\"}"

		return cnt == 1 ? new ResponseEntity<>(Integer.toString(cnt), HttpStatus.OK)
				: new ResponseEntity<>(Integer.toString(cnt), HttpStatus.OK);

	}

	/*
	 * @PostAuthorize("isAuthenticated() and (( returnObject.name == principal.name ) or hasRole('ROLE_ADMIN'))"
	 * )
	 */
//	@PostAuthorize("isAuthenticated() and hasRole('ROLE_MEMBER')")
//	@GetMapping("/mypage")
//	public void mypage() {
//		log.info("mypage.................");
//	}

	// 泥⑤��뙆�씪�궘�젣
//	private void deleteFiles(String id) {
//
//		MemberVO mVo = service.idread(id); 
//		
//			log.info("deleteFiles....." +id);
//		
//		if(mVo == null) {
//			
//			log.info(mVo);
//			log.info("mVo 瑜� 諛쏆븘�삤吏�紐삵빐�슂 �뀪�뀪");
//			return;
//		}
//		
//		log.info("profile delete.......................");
//		log.info(mVo);
//		
//		try {
//			
//			String thumbnailFile = mVo.getM_path();
//			String originalFile = thumbnailFile.substring(3);
//			
//			log.info(originalFile);
//			
//			Path Thumbnail = Paths.get("C:\\upload\\member"+thumbnailFile);
//			
//			Files.deleteIfExists(Thumbnail);
//			
//			Path file = Paths.get("C:\\upload\\member"+originalFile);
//			
//			Files.delete(file);
//		
//		}catch(Exception e) {
//			e.printStackTrace();
//		}
//	}

	//@PreAuthorize("principal.username == #member.m_id")
	@PostMapping("/modify")
	public String memberupdate(MemberVO member) {

		log.info("memberupdate....." + member);

		if (service.memberupdate(member)) {

			log.info("수정완료............");
		}

		return "redirect:/mypage/my_modify_check?myid=" + member.getM_id();
	}

	// 첨부파일삭제
//			private void deleteFiles(String id) {
	//
//				MemberVO mVo = service.idread(id); 
//				
//					log.info("deleteFiles....." +id);
//				
//				if(mVo == null) {
//					
//					log.info(mVo);
//					return;
//				}
//				
//				log.info("profile delete.......................");
//				log.info(mVo);
//				
//				try {
//					
//					String thumbnailFile = mVo.getM_path();
//					String originalFile = thumbnailFile.substring(3);
//					
//					log.info(originalFile);
//					
//					Path Thumbnail = Paths.get("C:\\upload\\member"+thumbnailFile);
//					
//					Files.deleteIfExists(Thumbnail);
//					
//					Path file = Paths.get("C:\\upload\\member"+originalFile);
//					
//					Files.delete(file);
//				
//				}catch(Exception e) {
//					e.printStackTrace();
//				}
//			}

	/*
	 * @PreAuthorize("principal.username == #myid")
	 */
	@GetMapping("/delete")
	public String memberdelete(@RequestParam("myid") String id, RedirectAttributes rttr) {

		log.info("memberdelete....." + id);

		if (service.memberdelete(id)) {

			log.info("회원탈퇴완료");

		}
		rttr.addFlashAttribute("message", "logout");
		return "redirect:/home";

	}


	private boolean checkImageType(File file) {

		log.info("이미지 타입 체크중!!");

		try {
			String contentType = Files.probeContentType(file.toPath());

			return contentType.startsWith("image");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}


	@PostMapping(value = "/uploadimg", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<MemberVO>> uploadimg(MultipartFile[] uploadFile, Model model) {

		log.info("uploadimg.........");

		List<MemberVO> list = new ArrayList<>();

		String uploadFolder = "C:\\upload\\member";

		// make foleder------

		File uploadPath = new File(uploadFolder);
		log.info("upload path:" + uploadPath);

		if (uploadPath.exists() == false) {
			uploadPath.mkdir();
		}

		for (MultipartFile multipartFile : uploadFile) {

			log.info("Upload File Name:" + multipartFile.getOriginalFilename());
			log.info("upload File Size:" + multipartFile.getSize());

			MemberVO mVo = new MemberVO();

			String uploadFileName = multipartFile.getOriginalFilename();

			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);

			mVo.setM_filename(uploadFileName);

			UUID uuid = UUID.randomUUID();

			uploadFileName = uuid.toString() + "_" + uploadFileName;

			try {
				File saveFile = new File(uploadFolder, uploadFileName);
				multipartFile.transferTo(saveFile);

				mVo.setM_uuid(uuid.toString());
				mVo.setM_path("member");

//							mVo.setM_path("/s_"+mVo.getM_uuid()+"_"+mVo.getM_filename());

				if (checkImageType(saveFile)) {
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));

					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);

					thumbnail.close();

				}

				list.add(mVo);

			} catch (Exception e) {
				log.error(e.getMessage());
			}

		}

		return new ResponseEntity<>(list, HttpStatus.OK);

	}

	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		log.info("fileName:" + fileName);

		File file = new File("c:\\upload\\member" + fileName);

		log.info("file:" + file);

		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();

			header.add("Content-type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


}
