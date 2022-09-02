package com.aircamp.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.aircamp.domain.PagingVO;
import com.aircamp.domain.ReplyPageVO;
import com.aircamp.domain.ReplyVO;
import com.aircamp.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RestController
@RequestMapping("/replies/")
@Log4j
@AllArgsConstructor
public class ReplyController {

	@Setter(onMethod_=@Autowired)
	private ReplyService service;

	/**
	 * 등록
	 * @param vo
	 * @return
	 */
	@PreAuthorize("isAuthenticated()")
	@PostMapping(value= "/new", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo) {
		
		log.info("ReplyVO :"+vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT : " + insertCount);
		
		return insertCount == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	/**
	 * 목록
	 * @param page
	 * @param c_id
	 * @return
	 */
	@GetMapping(value = "/pages/{c_id}/{page}", produces = {
			MediaType.APPLICATION_ATOM_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE
		})
	public ResponseEntity<ReplyPageVO> getList(
			@PathVariable("page") int page,
			@PathVariable("c_id") int c_id) {
		
		log.info("getList=================================");
		PagingVO paging = new PagingVO(page,10);
		
		log.info("==============================="+paging);
		return new ResponseEntity<>(service.getListPage(paging, c_id), HttpStatus.OK);
			
	}

	/**
	 * 조회
	 * @param r_id
	 * @return
	 */
	@GetMapping(value = "/{r_id}",
			produces = {
					MediaType.APPLICATION_ATOM_XML_VALUE,
					MediaType.APPLICATION_JSON_UTF8_VALUE
	})
	public ResponseEntity<ReplyVO> get(@PathVariable("r_id") Long r_id) {
		
		log.info("get======================"+r_id);
		
		return new ResponseEntity<>(service.get(r_id), HttpStatus.OK);
		
	}

	/**
	 * 삭제
	 * @param r_id
	 * @param vo
	 * @return
	 */
	@ResponseBody
	@PreAuthorize("principal.username == #vo.m_id")
	@DeleteMapping(value = "/{r_id}", produces = "text/plain; charset=UTF-8")
	public ResponseEntity<String> remove(@PathVariable("r_id") Long r_id, @RequestBody ReplyVO vo) {
		
		log.info("remove============================"+r_id);
		
		return service.remove(r_id) == 1
			? new ResponseEntity<>("success", HttpStatus.OK)
			: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	/**
	 * 수정
	 * @param vo
	 * @param r_id
	 * @return
	 */
	@PreAuthorize("principal.username == #vo.m_id")
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
				value = "/{r_id}",
				consumes = "application/json",
				produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("r_id") Long r_id){
		
	
		log.info("r_id=========================="+r_id);
		log.info("r_id=========================="+vo);
		
		return service.modify(vo) == 1
			? new ResponseEntity<>("success", HttpStatus.OK)
			: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
