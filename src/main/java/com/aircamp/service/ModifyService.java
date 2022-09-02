package com.aircamp.service;

import java.util.List;

import com.aircamp.domain.GalleryVO;
import com.aircamp.domain.ItemVO;

public interface ModifyService {
	public ItemVO getItem(ItemVO item);
	
	public List<GalleryVO> getGalleryList(GalleryVO gVO);
	
	public boolean updateItem(ItemVO item);
	
	public ItemVO detailRemove(ItemVO item);
}
