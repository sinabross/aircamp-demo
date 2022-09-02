package com.aircamp.controller;

import java.util.List;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.aircamp.domain.GalleryVO;
import com.aircamp.domain.ItemThumbnailVO;
import com.aircamp.service.ItemService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/home")
@AllArgsConstructor
@Log4j 
public class HomeController {
	private ItemService itemService;

	@GetMapping("")
	public void home(Model model) {
		// List<ItemThumnailVO> itemThumnailList = itemService.getAllItemList();
		
		List<ItemThumbnailVO> itemThumbnailList = itemService.getHomeItemThumbnailList();

		// List<ItemThumnailVO>
//		model.addAttribute("itemlist", itemService.getAllItemList());
//		for(int i=0; i<itemThumnailList.size();i++) {
//			itemThumnailList.get(i).setG_id(galleryList.get(i).getG_id());
//			itemThumnailList.get(i).setG_photo(galleryList.get(i).getG_photo());
//
//		}
		log.info(itemThumbnailList);
		// log.info(galleryList);

		model.addAttribute("itemThumbnailList", itemThumbnailList);
	}

	/*
	 * @GetMapping("/showThumbnailImg") public ResponseEntity<Resource>
	 * showTumnailImg(@RequestParam("path") String path, @RequestParam("uuid")
	 * String uuid,
	 * 
	 * @RequestParam("fileName") String fileName) { log.info("homeThumbnail"); //
	 * Resource resource = new
	 * FileSystemResource("C:\\upload\\"+path+"\\s_"+uuid+fileName); Resource
	 * resource = new FileSystemResource("C:\\upload\\" + path + "\\" + uuid +
	 * fileName);
	 * 
	 * HttpHeaders headers = new HttpHeaders();
	 * 
	 * headers.add("Content-Disposition", "attachment; filename=" + fileName);
	 * 
	 * return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK); }
	 */

}
