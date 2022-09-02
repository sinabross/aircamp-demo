package com.aircamp.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aircamp.domain.ItemVO;
import com.aircamp.domain.PageVO;
import com.aircamp.domain.PagingVO;
import com.aircamp.domain.ShareVO;
import com.aircamp.service.ItemService;
import com.aircamp.service.MemberService;
import com.aircamp.service.MypageService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@PreAuthorize("isAuthenticated() and principal.username == #myid")
@RequestMapping("/mypage")
@Log4j
@AllArgsConstructor
public class MypageController {

	private MypageService mypageService;
	private MemberService memberService;
	private ItemService itemService;


	BCryptPasswordEncoder passwordEncoder;

	@PostMapping("/my_reservation")
	public void myreservation(String myid, int pageNum, int amount, Model model) {
		log.info("mypage_Reservation................");

		PagingVO pagingVO = new PagingVO(pageNum, amount);
		pageNum = pagingVO.getPageNum();
		amount = pagingVO.getAmount();

		int total = mypageService.mypageShareGetTotalCount(myid, pageNum, amount);

		model.addAttribute("list", mypageService.mypageShareList(myid, pageNum, amount));
		model.addAttribute("pageMaker", new PageVO(pagingVO, total));

	}

	@PostMapping("/my_share")
	public void myshare(String myid, int pageNum,int amount, Model model) {
		log.info("mypage_Item................");

		PagingVO pagingVO = new PagingVO(pageNum, amount);
		pageNum = pagingVO.getPageNum();
		amount = pagingVO.getAmount();

		int total = mypageService.mypageItemGetTotalCount(myid, pageNum, amount);

		List<ItemVO> mypageShareList = mypageService.mypageItemWithPaging(myid, pageNum, amount);
		log.info("getReservationList: " + mypageShareList);

		for (ItemVO ivo : mypageShareList) {
			ivo.setShareList(mypageService.getReservationListByIid(ivo.getI_id()));
			log.info("getReservationList: " + ivo.getShareList());
		}
		/*
		 * 
		 * List<ShareVO> reservationList = mypageService.getReservationListByIid(i_id);
		 * log.info("getReservationList: " + reservationList);
		 */

		model.addAttribute("list", mypageShareList);
		model.addAttribute("pageMaker", new PageVO(pagingVO, total));
	}

	@PostMapping("/my_community")
	public void mycommunity(String myid, int pageNum, int amount, Model model) {
		log.info("mypage_Community................");

		PagingVO pagingVO = new PagingVO(pageNum, amount);
		pageNum = pagingVO.getPageNum();
		amount = pagingVO.getAmount();

		int total = mypageService.mypageCommGetTotalCount(myid, pageNum, amount);

		model.addAttribute("list", mypageService.mypageCommListWithPaging(myid, pageNum, amount));
		model.addAttribute("pageMaker", new PageVO(pagingVO, total));

	}
	@PostMapping("/my_contactus")
	public void mycontactus(String myid, int pageNum,int amount, Model model) {
		log.info("mypage_Contactus................");

		PagingVO pagingVO = new PagingVO(pageNum, amount);
		pageNum = pagingVO.getPageNum();
		amount = pagingVO.getAmount();

		int total = mypageService.mypageQnaGetTotalCount(myid, pageNum, amount);

		model.addAttribute("list", mypageService.mypageQnaListWithPaging(myid, pageNum, amount));
		model.addAttribute("pageMaker", new PageVO(pagingVO, total));
	}

	@GetMapping("/my_modify_check")
	public void mymodify(String myid) {
		log.info("mypage_modify_check................");
	}

	@PostMapping("/my_delete")
	public void mydelete(String myid) {
		log.info("mypage_delete................");
	}

	@GetMapping("/my_modify")
	public void modify(@RequestParam("myid") String myid, Model model) {
		log.info("modify Get........");

		model.addAttribute("member", memberService.idread(myid));

	}

	
	@PostMapping("/pwcheck")
	public String pwcheck(@RequestParam("m_pw") String pw, @RequestParam("myid") String myid, Model model,
			RedirectAttributes rttr) {
		log.info("pwcheck......................");

		log.info("입력한 패스워드" + pw);

		log.info("id.. :" + myid);

		Boolean pwchk = passwordEncoder.matches(pw, mypageService.pwcheck(myid));

		log.info("인코딩한 패스워드:" + pwchk);

		if (pwchk) {
			model.addAttribute("member", memberService.idread(myid));
			rttr.addAttribute("myid",myid);
			model.addAttribute("myid",myid);
			log.info("success");
			return "redirect:/mypage/my_modify";

		} else {
			rttr.addFlashAttribute("message", "잘못된 비밀번호입니다");
			rttr.addFlashAttribute("myid",myid);

			return "redirect:/mypage/my_modify_check";

		}

	}

	@PostMapping("/pwcheck_delete")
	public String pwcheckDelete(@RequestParam("m_pw") String pw, @RequestParam("myid") String myid, Model model,
			RedirectAttributes rttr) {
		log.info("pwcheck......................");

		log.info("pw..:" + pw);

		log.info("id.. :" + myid);

		Boolean pwchk = passwordEncoder.matches(pw, mypageService.pwcheck(myid));

		if (pwchk) {
			log.info("탈퇴 성공.......");
			return "redirect:/member/delete?myid=" + myid;

		} else {
			rttr.addFlashAttribute("message", "잘못된 비밀번호입니다");
			return "redirect:/mypage/my_delete?myid=" + myid;

		}

	}


	@GetMapping("/my_reservation_cancel")
	public void myReservationCancel( ) {
		log.info("My_Re_Cancel");

	}

	@GetMapping("/shareDelete")
	public String myshareDelete(@RequestParam("myid") String myid, @RequestParam("s_id") Long s_id) {

		if (mypageService.mypageShareDelete(myid, s_id)) {
			log.info("삭제완료");
		}

		return "redirect:/mypage/my_reservation_cancel?m_id=" + myid;

	}

	@PostMapping("/sharecanclehost")
	public String myshareDeleteHost(ShareVO svo, String myid) {
		log.info("sharecanclehost==========" +myid);

		ItemVO ivo = itemService.getItemDetail(svo.getI_id());
		if (ivo.getM_id().equals(myid)) {
			if (mypageService.mypageShareDelete(svo.getM_id(), svo.getS_id())) {
				log.info("삭제완료");
			}

		}

		return "redirect:/mypage/my_reservation_cancel?m_id=" + myid;
	}
}
