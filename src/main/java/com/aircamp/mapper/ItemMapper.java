package com.aircamp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.aircamp.domain.Criteria;
import com.aircamp.domain.ItemThumbnailVO;
import com.aircamp.domain.ItemVO;
import com.aircamp.domain.ShareMemberVO;
import com.aircamp.domain.ShareVO;

public interface ItemMapper {
	
	public List<ItemThumbnailVO> getAllItemThumbnail();
	public List<ItemThumbnailVO> getHomeItemThumbnail();
	public List<ItemVO> getAllItems();
	public List<ItemVO>  searchResult();
	
//	20190731예락


	/*
	 *  V1 수정 - 190808 yerak
	 *  
	 */
	public List<ItemVO> getItemDetailAll(Long i_id);

	public ItemVO getItemDetail(Long i_id);
	
	public List<ShareVO> getItemShare(Long i_id);
	
	public List<ShareMemberVO> getItemReviewAll(@Param("cri") Criteria cri, @Param("i_id") Long i_id);
	
	public int getReviewCount(Long i_id);
	
	public int reservation(ShareVO share);
	
	public List<ItemVO> getHostItem(String m_id);
	
	public List<ItemVO> getSearchList(@Param("addr") String addr, @Param("sdate") String sdate,
								@Param("edate") String edate, @Param("title") String title);
	public int deleteMemberItem(@Param("m_id") String m_id);
//  20190806재훈
	
	
	
}
