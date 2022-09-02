package com.aircamp.mapper;

import java.util.List;

import com.aircamp.domain.GalleryVO;

public interface GalleryMapper {
	
	public List<GalleryVO> findByIid(Long i_id);
}
