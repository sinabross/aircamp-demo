package com.aircamp.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.aircamp.domain.Criteria;
import com.aircamp.domain.ItemVO;
import com.aircamp.domain.ReviewPageDTO;
import com.aircamp.domain.ShareVO;
import com.aircamp.service.ItemService;
import com.aircamp.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/review/*")
@RestController
@Log4j
@AllArgsConstructor
public class ReviewController {
	
	private ItemService itemService;
	
	private ReviewService reviewService;

	@PostMapping(value="/addMypageReview", consumes="application/json", produces= { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> addReviewMypage(@RequestBody ShareVO share, Model model){
		log.info("/ShareVO===============: "+ share);
		log.info("/ShareVO===============: " + reviewService.getReview(share));
		
		ShareVO review = reviewService.getReview(share);
		int regCount = 0;
		
		if(review==null) {
			model.addAttribute("nosuccess", "후기를 등록할 수 없습니다.");
			
		}else {
			review.setS_opi(share.getS_opi());
			review.setS_score_i(share.getS_score_i());
			review.setS_score_m(share.getS_score_m());
			
			regCount = reviewService.addMypageReview(review);
			
			if(regCount==1) {
				log.info("/ShareVO=====update score: " + review);
				reviewService.updateItemScore(review);
				reviewService.updateMemberScore(review);
			}
		}
		
		log.info("/ShareVO===============: " + review);		
		log.info("=====review register count=====: "+ regCount);
		
		return regCount==1 ? new ResponseEntity<>("success",HttpStatus.OK)
								: new ResponseEntity<>("fail", HttpStatus.OK);
	}
	
	
	
	
	
	
	
	
	
	@PostMapping(value="/addReview", consumes="application/json", produces= { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create(@RequestBody ShareVO share, Model model){
		log.info("/ShareVO===============: "+ share);
		log.info("/ShareVO===============: " + reviewService.getReview(share));
		
		ShareVO review = reviewService.getReview(share);
		int regCount = 0;
		
		if(review==null) {
			model.addAttribute("nosuccess", "후기를 등록할 수 없습니다.");
		}else {
			review.setS_opi(share.getS_opi());
			review.setS_score_i(share.getS_score_i());
			review.setS_score_m(share.getS_score_m());
			
			regCount = reviewService.addReview(review);
			
			if(regCount==1) {
				log.info("/ShareVO=====update score: " + review);
				reviewService.updateItemScore(review);
				reviewService.updateMemberScore(review);
			}
		}
		
		log.info("/ShareVO===============: " + review);		
		log.info("=====review register count=====: "+ regCount);
		
		return regCount==1 ? new ResponseEntity<>("success",HttpStatus.OK)
								: new ResponseEntity<>("fail", HttpStatus.OK);
	}

	
	@GetMapping(value="/getStarScore/{i_id}", produces = {MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ItemVO> getStarScore(@PathVariable("i_id") Long i_id){
		log.info("getStarScore.....................");
		
		log.info(itemService.getItemDetail(i_id));
		
		return new ResponseEntity<>(itemService.getItemDetail(i_id), HttpStatus.OK);
	}
	
	
	@GetMapping(value="/getReviewList/{i_id}/{page}", produces = {MediaType.APPLICATION_XML_VALUE,
															MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReviewPageDTO> getList(@PathVariable("page") int page, @PathVariable("i_id") Long i_id){
		log.info("getList.....................");
		Criteria cri = new Criteria(page, 10);
		log.info(cri);
		log.info(itemService.getReviewListPage(cri, i_id));
		
		return new ResponseEntity<>(itemService.getReviewListPage(cri, i_id), HttpStatus.OK);
	}
	
	@GetMapping(value="/{s_id}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ShareVO> get(@PathVariable("s_id") Long s_id){
		log.info("get: "+ s_id);
		return new ResponseEntity<>(reviewService.readReview(s_id), HttpStatus.OK);
	}
	
	//@PreAuthorize("principal.member.m_id==#sharevo.m_id")
	@RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH}, value= "/{s_id}",
																	consumes="application/json",
																	produces= "text/plain; charset=UTF-8")
	public ResponseEntity<String> modify(@RequestBody ShareVO sharevo,
										@PathVariable("s_id") Long s_id){
		
		log.info("s_id: " + s_id);
		log.info("update: "+ sharevo);
		
		return reviewService.updateReview(sharevo)==1? new ResponseEntity<>("수정되었습니다.",HttpStatus.OK)
		
									: new ResponseEntity<>("수정에 실패하였습니다.", HttpStatus.OK);
	}
	
	//@PreAuthorize("principal.member.m_id==#sharevo.m_id")
	@PostMapping(value= "/deleteReview", consumes="application/json", produces= "text/plain; charset=UTF-8")
	public ResponseEntity<String> remove(@RequestBody ShareVO sharevo){
		log.info("delete: "+ sharevo);
		
		long deleteSid = sharevo.getS_id();
		
		log.info(deleteSid);
		
		if(reviewService.deleteReview(deleteSid)==1) {
			reviewService.deleteItemScore(sharevo);
			reviewService.deleteMemberScore(sharevo);
		}
		
		return reviewService.deleteReview(deleteSid)==1? new ResponseEntity<>("삭제되었습니다.",HttpStatus.OK)
				
				: new ResponseEntity<>("삭제에 실패하였습니다.", HttpStatus.OK);
	}
	
}
