/*
 * package com.aircamp.controller;
 * 
 * import javax.annotation.Resource;
 * 
 * import org.springframework.core.io.FileSystemResource; import
 * org.springframework.http.HttpHeaders; import
 * org.springframework.http.HttpStatus; import
 * org.springframework.http.ResponseEntity; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.web.bind.annotation.GetMapping; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestParam; import
 * org.springframework.web.bind.annotation.ResponseBody;
 * 
 * import com.aircamp.domain.GalleryVO; import
 * com.aircamp.service.SearchService;
 * 
 * import lombok.extern.log4j.Log4j;
 * 
 * @Controller
 * 
 * @RequestMapping("/*")
 * 
 * @Log4j public class ThumbnailController {
 * 
 * @Resource(name = "searchService") SearchService searchService;
 * 
 * @GetMapping(value = "/showThumbnail")
 * 
 * @ResponseBody public ResponseEntity<FileSystemResource>
 * showThumbnail(@RequestParam("galleryId") String g_id) {
 * 
 * log.info("showThumbnail" + g_id);
 * 
 * GalleryVO g_vo= searchService.getThumnailPhoto(g_id);
 * 
 * String path=g_vo.getG_path(); String uuid=g_vo.getG_uuid(); String
 * filename=g_vo.getG_filename();
 * 
 * FileSystemResource resource = new
 * FileSystemResource("C:\\upload\\" + path.replace("\\","\\\\") + "
 * \\" +uuid + "_" + filename);
 * 
 * HttpHeaders headers = new HttpHeaders();
 * 
 * headers.add("Content-Disposition", "attachment; filename=" + filename);
 * 
 * return new ResponseEntity<FileSystemResource>(resource, headers,
 * HttpStatus.OK);
 * 
 * }
 * 
 * }
 */