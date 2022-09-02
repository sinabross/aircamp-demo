package com.aircamp.mapper;

import java.util.List;


import com.aircamp.domain.GalleryVO;
import com.aircamp.domain.ItemVO;


public interface ModifyMapper {
	public ItemVO addByIid(ItemVO item);
	
	public List<GalleryVO> fileByIid(GalleryVO gVO);
	
	public int updateItem(ItemVO item);
	
	public void deleteAll(ItemVO item);
	
	public void detailRemove(ItemVO item);
}
