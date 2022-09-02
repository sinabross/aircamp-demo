package com.aircamp.service;

import java.util.List;

import com.aircamp.domain.Criteria;
import com.aircamp.domain.GalleryVO;
import com.aircamp.domain.ItemThumbnailVO;
import com.aircamp.domain.ItemVO;
import com.aircamp.domain.ReviewPageDTO;
import com.aircamp.domain.ShareMemberVO;
import com.aircamp.domain.ShareVO;

public interface ItemService {
	public List<ItemVO> getAllItemList();

	public List<ItemThumbnailVO> getAllItemThumbnailList();
	public List<ItemThumbnailVO> getHomeItemThumbnailList();
//	public List<GalleryVO> getThumnailImg();

	
	public List<ItemVO> getItemDetailAll(Long i_id);

	public ItemVO getItemDetail(Long i_id);

	public List<GalleryVO> getGalleryList(Long i_id);
	
	public List<ShareVO> getItemShare(Long i_id);
	
	public List<ShareMemberVO> getItemReviewAll(Criteria cri, Long i_id);
	
	public ReviewPageDTO getReviewListPage(Criteria cri, Long i_id);
	
	public int reservation(ShareVO share);
	
	public List<ItemVO> getHostItem(String m_id);
	
	public List<ItemVO> getSearchList(String addr, String sdate, String edate, String title);
}
