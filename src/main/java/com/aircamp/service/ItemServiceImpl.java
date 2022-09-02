package com.aircamp.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aircamp.domain.Criteria;
import com.aircamp.domain.GalleryVO;
import com.aircamp.domain.ItemThumbnailVO;
import com.aircamp.domain.ItemVO;
import com.aircamp.domain.ReviewPageDTO;
import com.aircamp.domain.ShareMemberVO;
import com.aircamp.domain.ShareVO;
import com.aircamp.mapper.GalleryMapper;
import com.aircamp.mapper.ItemMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor

public class ItemServiceImpl implements ItemService {

	private ItemMapper itemMapper;
	private GalleryMapper galleryMapper;

	@Override
	public List<ItemVO> getAllItemList() {
		
		return itemMapper.getAllItems();
	}

	@Override
	public List<ItemThumbnailVO> getAllItemThumbnailList() {
		
		return itemMapper.getAllItemThumbnail();
	}

	@Override
	public List<ItemThumbnailVO> getHomeItemThumbnailList() {
		// TODO Auto-generated method stub
		return itemMapper.getHomeItemThumbnail();
	}

	@Override
	public List<ItemVO> getItemDetailAll(Long i_id) {
		log.info("getItemDetailAll............." + i_id + itemMapper.getItemDetailAll(i_id));
		
		return itemMapper.getItemDetailAll(i_id);
	}
	
	@Override
	public ItemVO getItemDetail(Long i_id) {
		log.info("getItemDetail..............."+ i_id + itemMapper.getItemDetail(i_id));
		
		return itemMapper.getItemDetail(i_id);
	}
	
	@Override 
	public List<GalleryVO> getGalleryList(Long i_id) {
		log.info("======gallery list by i_id======: " + i_id);
	  
		return galleryMapper.findByIid(i_id);
	
	}
	
	@Override
	public List<ShareVO> getItemShare(Long i_id) {
		log.info("getItemShare..........." + i_id + itemMapper.getItemShare(i_id));
		
		return itemMapper.getItemShare(i_id);
	}

	@Override
	public List<ShareMemberVO> getItemReviewAll(Criteria cri, Long i_id) {
		
		return itemMapper.getItemReviewAll(cri, i_id);
	}

	@Override
	public ReviewPageDTO getReviewListPage(Criteria cri, Long i_id) {
		return new ReviewPageDTO(itemMapper.getReviewCount(i_id), itemMapper.getItemReviewAll(cri, i_id));
	}
	
	@Override
	public int reservation(ShareVO share) {
		
		return itemMapper.reservation(share);
	}
	
	@Override
	public List<ItemVO> getHostItem(String m_id) {
		
		return itemMapper.getHostItem(m_id);
	}
	
	@Override
	public List<ItemVO> getSearchList(String addr, String sdate, String edate, String title) {
		return itemMapper.getSearchList(addr, sdate, edate, title);
	}
	
	

}
