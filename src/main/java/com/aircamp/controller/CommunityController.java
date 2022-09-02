package com.aircamp.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aircamp.domain.CommunityVO;
import com.aircamp.domain.PageVO;
import com.aircamp.domain.PagingVO;
import com.aircamp.service.CommunityService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/community/*")
@Log4j
@AllArgsConstructor
public class CommunityController {

	private CommunityService service;

	/**
	 *  목록
	 * @param paging
	 * @param model
	 */
	@GetMapping("/list")
	public void list(PagingVO paging, Model model) {
		log.info("list"+paging);
		
		model.addAttribute("list", service.getList(paging));
		

		// 전체 데이터 수
		/*model.addAttribute("pageMaker", new PageVO(paging, 123));*/
		int total = service.getTotal(paging);
		
		
		log.info("total :" + total);
		
		model.addAttribute("pageMaker", new PageVO(paging, total));
	}
	/*
	 * public void list(Model model) { log.info("list");
	 * 
	 * model.addAttribute("list", service.getList()); }
	 */

	/**
	 * 등록
	 * @param comm
	 * @param rttr
	 * @return
	 */
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@PostMapping("/register")
	public String register(CommunityVO comm, RedirectAttributes rttr) {
		log.info("register :"+ comm);
		
		service.register(comm);
		
		rttr.addFlashAttribute("result", comm.getC_id());
		
		return "redirect:/community/list";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_MEMBER')")
	@GetMapping("/register")
	public void register() {
		
	}

	/**
	 * 조회
	 * @param c_id
	 * @param paging
	 * @param model
	 */
	@GetMapping({"/get","/modify"})
	public void get(@RequestParam("c_id") Long c_id, @ModelAttribute("paging") PagingVO paging, Model model) {
		log.info("/get or modify");
		
		service.updateViewCnt(c_id);
		
		model.addAttribute("comm", service.get(c_id));
		
	}

	/**
	 * 수정
	 * @param comm
	 * @param paging
	 * @param rttr
	 * @return
	 */
	@PreAuthorize("principal.username == #comm.m_id")
	@PostMapping("/modify")
	public String modify(CommunityVO comm, @ModelAttribute("paging") PagingVO paging, RedirectAttributes rttr) {
		log.info("modify :"+comm);
		
		if(service.modify(comm)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		
		return "redirect:/community/list" + paging.getListLink();
		
	}

	/**
	 * 삭제
	 * @param c_id
	 * @param paging
	 * @param rttr
	 * @param m_id
	 * @return
	 */
	@PreAuthorize("principal.username == #m_id")
	@PostMapping("/remove")
	public String remove(@RequestParam("c_id") Long c_id, @ModelAttribute("paging") PagingVO paging,  RedirectAttributes rttr, String m_id) {
		
		log.info("remove :"+c_id);
		if(service.remove(c_id) ) {
			rttr.addFlashAttribute("result", "succes");
		}
		
		return "redirect:/community/list" + paging.getListLink();
		
	}
	
}
