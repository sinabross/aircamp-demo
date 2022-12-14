package com.aircamp.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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

import com.aircamp.domain.GalleryVO;
import com.aircamp.domain.ItemVO;
import com.aircamp.domain.PageVO;
import com.aircamp.domain.PagingVO;
import com.aircamp.domain.ShareVO;
import com.aircamp.service.AddService;
import com.aircamp.service.ItemService;
import com.aircamp.service.ModifyService;
import com.aircamp.service.SearchService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@RequestMapping("/item/*")
@Log4j
@AllArgsConstructor
public class ItemController {

	private AddService addService;
	private ItemService itemService;
	private SearchService searchService;
	private ModifyService modifyService;

	@GetMapping("/detail")
	public String get(@RequestParam("i_id") Long i_id, Model model) {
		log.info("/detail======================: " + i_id + itemService.getItemDetailAll(i_id));
		log.info("/detail======================: " + i_id + itemService.getItemShare(i_id));
		//log.info("/detail======================: " + i_id + service.getItemReviewAll(i_id));
		
		ItemVO item = itemService.getItemDetail(i_id);
		String m_id = item.getM_id();
		
		log.info("/detail======================: " + m_id);
		log.info("/detail======================: " + itemService.getHostItem(m_id));
		
		model.addAttribute("item", itemService.getItemDetailAll(i_id));
		model.addAttribute("share", itemService.getItemShare(i_id));
		//model.addAttribute("opinion", service.getItemReviewAll(i_id));
		model.addAttribute("host", itemService.getHostItem(m_id));

		return "/item/detail";
	}

	@PostMapping("/reservation")
	public String reservation(ShareVO share, RedirectAttributes rttr) {
		log.info("=====reservation=====: " + share);
		
		int result = itemService.reservation(share);
		log.info("=====result=====: " + result);
		
		rttr.addFlashAttribute("result", result);
		rttr.addFlashAttribute("reservation", share);
		
		String resultPage="redirect:/item/detail?i_id=" + share.getI_id();
		
		if(result==1) {
			resultPage = "redirect:/item/result";
		}else if(result==0) {
			rttr.addFlashAttribute("fail", "????????? ?????????????????????.");
			resultPage = "redirect:/item/detail?i_id=" + share.getI_id();
			
		}
		
		return resultPage;
	}
	
	@GetMapping("/result")
	public void result() {}
	
	
	@GetMapping("/displayImage")
	@ResponseBody
	public ResponseEntity<byte[]> getFileImage(String fileName) throws IOException{
		log.info("========================fileName: " + fileName);
		File file = new File("c:\\upload\\" + fileName);
		
		log.info("file" + file);
		
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		try {
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),
					header, HttpStatus.OK);
		}catch(IOException e) {
			e.printStackTrace();
			
			log.info("????????? ???????????? ??????");
			
			//???????????? ???????????? ?????? ?????? ?????? ????????? ??????
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(new File("c:\\upload\\img_no_image.png")), header, HttpStatus.OK);
			
		}
		return result;
	}
	
	
	@GetMapping("/displayMember")
	@ResponseBody
	public ResponseEntity<byte[]> getFileMember(String fileName) throws IOException{
		log.info("========================fileName: " + fileName);
		File file = new File("c:\\upload\\" + fileName);
		
		log.info("file" + file);
		
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		try {
			
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),
					header, HttpStatus.OK);
		}catch(IOException e) {
			e.printStackTrace();
			
			log.info("????????? ???????????? ??????");
			
			//???????????? ???????????? ?????? ?????? ?????? ????????? ??????
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(new File("c:\\upload\\img_member_default.png")), header, HttpStatus.OK);
			
		}
		return result;
	}
		
	
	//????????? ????????????
	@GetMapping(value="/getGalleryList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<GalleryVO>> getGalleryList(GalleryVO gVO) {
		
		log.info("???????????? ????????? ????????????");
		
		
		return new ResponseEntity<List<GalleryVO>>(modifyService.getGalleryList(gVO), HttpStatus.OK);
	}
	
	// ????????? ????????? ????????????
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		log.info("========================fileName: " + fileName);
		File file = new File("c:\\upload\\" + fileName);

		log.info("file" + file);

		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();

			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}

//	@PostMapping("/reservation")
//	public String reservation(ShareVO share, Model model) {
//		log.info("=====reservation=====: " + share);
//
//		itemService.reservation(share);
//		model.addAttribute("reservation", share);
//
//		return "/item/reservation";
//	}



	@GetMapping("/add")
	public String add() {
		log.info("/add==========");
		return "/item/add";
	}

	// ?????? ?????? ??????
	private String getFolder() {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

		Date date = new Date();

		String str = sdf.format(date);

		return str.replace("-", File.separator);// ????????? ????????? ????????? str ????????? ?????? ??????????????????
	}

	// ????????? ???????????? ???????????? ??????
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());

			return contentType.startsWith("image");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return false;
	}

	
	//???????????????
	@PostMapping(value="/uploadAjax", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<GalleryVO>> uploadAjax(MultipartFile[] uploadFile) {
		log.info("upload ajax");
		
		List<GalleryVO> list = new ArrayList<GalleryVO>();
		
		String uploadFolder = "C:\\upload\\";
		String uploadFolderPath = getFolder();
		
		File uploadPath = new File(uploadFolder , uploadFolderPath);
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		for (MultipartFile multipartFile : uploadFile) {
			
			GalleryVO galleryVO = new GalleryVO();
			
			log.info("upload File Name" + multipartFile.getOriginalFilename());
			log.info("upload File Size" + multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			
			//IE?????? ?????????
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			
			galleryVO.setG_filename(uploadFileName);
			
			//uuid??? ????????? ????????? ?????? uploadFileName??? ?????????
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			try {
				File saveFile = new File(uploadPath, uploadFileName);
				multipartFile.transferTo(saveFile);
				
				galleryVO.setG_uuid(uuid.toString());
				galleryVO.setG_path(uploadFolderPath);
				
				//?????? ??????????????? ???????????? ?????? ??????
				if (checkImageType(saveFile)) {
					
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					log.info("????????? ????????????" + thumbnail);
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 200, 200);
					
					thumbnail.close();
				}
				
				//????????? ?????? ???????????? ??????
				list.add(galleryVO);
				
			} catch (Exception e) {
				log.error(e.getMessage());
			}
			
		}
		return new ResponseEntity<List<GalleryVO>>(list, HttpStatus.OK);
	}

	/*
	 * // ????????? ????????? ????????????
	 * 
	 * @GetMapping("/display")
	 * 
	 * @ResponseBody public ResponseEntity<byte[]> getFile(String fileName) {
	 * 
	 * File file = new File("c:\\upload\\" + fileName);
	 * 
	 * ResponseEntity<byte[]> result = null;
	 * 
	 * log.info("?????????????????????");
	 * 
	 * try { HttpHeaders header = new HttpHeaders();
	 * 
	 * header.add("Content-Type", Files.probeContentType(file.toPath())); result =
	 * new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header,
	 * HttpStatus.OK); } catch (Exception e) { e.printStackTrace(); } return result;
	 * }
	 */

	// x?????? ????????? ????????????
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		log.info("????????????" + fileName);
		File file;

		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));

			file.delete();

			String largeFileName = file.getAbsolutePath().replace("s_", "");
			file = new File(largeFileName);

			file.delete();
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}


	//????????? ??????
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/register")
	public String register(ItemVO item, RedirectAttributes rttr) {
		log.info("register: "+item);
		
		
		if (item.getGalleryList() != null) {
			item.getGalleryList().forEach(attach -> log.info(attach));
		}
		
		
		addService.register(item);
		/* rttr.addFlashAttribute("result",board.getBno()); */
		//rttr.addFlashAttribute("result","OK");
		
		return "redirect:/item/detail?i_id="+item.getI_id();
	}
	
	@GetMapping("/search")
	public String search(Model model, @RequestParam("iAddr") String iAddr, @RequestParam("iSdate") String iSdate,
			@RequestParam("iEdate") String iEdate, @RequestParam("iTitle") String iTitle, @RequestParam("pageNum")int pageNum, @RequestParam("amount")int amount) throws Exception {

		log.info("????????? :" + iAddr);
		log.info("??????????????????" + iSdate);
		log.info("???????????????" + iEdate);
		log.info("????????????" + iTitle);

		PagingVO pagingVO = new PagingVO(pageNum, amount);
		pageNum = pagingVO.getPageNum();
		amount = pagingVO.getAmount();
		log.info("pageNum" + pageNum);
		log.info("amount" + amount);

			
		log.info(searchService.searchList(iAddr, iSdate, iEdate, iTitle, pageNum, amount));

		model.addAttribute("searchList", searchService.searchList(iAddr, iSdate, iEdate, iTitle, pageNum, amount));
		
		int total = searchService.searchGetTotal(pagingVO,iAddr, iSdate, iEdate, iTitle);
		
		log.info("total" + total);
		model.addAttribute("pageMaker", new PageVO(pagingVO, total));
		model.addAttribute("iaddr",iAddr);
		model.addAttribute("isdate",iSdate);
		model.addAttribute("iedate",iEdate);
		model.addAttribute("ititle",iTitle);

		log.info("searchresult=="+searchService.searchList(iAddr, iSdate, iEdate, iTitle, pageNum, amount));
		return "/item/item";
	}


	@GetMapping("/all")
	public String allItemList(Model model) {
		log.info("/item/all");
		model.addAttribute("searchList", itemService.getAllItemThumbnailList());

		return "redirect:/item/search?pageNum=1&amount=10&iAddr=&iSdate=&iEdate=&iTitle=";
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/modify")
	public void getModifyList(ItemVO item, Model model) {

		log.info("???????????? ????????? ????????????" + item);

		model.addAttribute("getItem", modifyService.getItem(item));
	}

	@PostMapping("/successModify")
	public String successModify(ItemVO item) {

		log.info("????????????");
		log.info(item);
		modifyService.updateItem(item);

		return "redirect:/item/detail?i_id="+item.getI_id();
	}

	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/itemRemove")
	public String itemRemove(ItemVO item) {

		log.info("???????????????????????? ????????????");

		modifyService.detailRemove(item);

		return "redirect:/main";

	}
}
