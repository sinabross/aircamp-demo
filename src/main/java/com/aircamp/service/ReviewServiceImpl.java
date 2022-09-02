package com.aircamp.service;

import org.springframework.stereotype.Service;

import com.aircamp.domain.ShareVO;
import com.aircamp.mapper.ReviewMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ReviewServiceImpl implements ReviewService {
	
	private ReviewMapper reviewMapper;
	
	@Override
	public ShareVO getReview(ShareVO share) {

		return reviewMapper.getReview(share);
	}

	@Override
	public int addReview(ShareVO share) {
		
		return reviewMapper.addReview(share);
	}

	@Override
	public ShareVO readReview(Long s_id) {
		
		return reviewMapper.readReview(s_id);
	}

	@Override
	public int updateReview(ShareVO share) {
		
		return reviewMapper.updateReview(share);
	}

	@Override
	public int deleteReview(Long s_id) {
		
		return reviewMapper.deleteReview(s_id);
	}

	@Override
	public int updateItemScore(ShareVO share) {
		
		return reviewMapper.updateItemScore(share);
	}

	@Override
	public int updateMemberScore(ShareVO share) {
		
		return reviewMapper.updateMemberScore(share);
	}

	@Override
	public int deleteItemScore(ShareVO share) {
		
		return reviewMapper.deleteItemScore(share);
	}

	@Override
	public int deleteMemberScore(ShareVO share) {
		
		return reviewMapper.deleteMemberScore(share);
	}

	@Override
	public int addMypageReview(ShareVO share) {
		// TODO Auto-generated method stub
		return reviewMapper.addMypageReview(share);
	}

	
}
