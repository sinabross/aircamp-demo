package com.aircamp.mapper;

import com.aircamp.domain.ShareVO;

public interface ReviewMapper {
	
	public ShareVO getReview(ShareVO share);
	
	public int addReview(ShareVO share);

	public int addMypageReview(ShareVO share);

	public ShareVO readReview(Long s_id);
	
	public int updateReview(ShareVO share);
	
	public int deleteReview(Long s_id);
	
	public int updateItemScore(ShareVO share);
	
	public int updateMemberScore(ShareVO share);
	
	public int deleteItemScore(ShareVO share);
	
	public int deleteMemberScore(ShareVO share);

}
