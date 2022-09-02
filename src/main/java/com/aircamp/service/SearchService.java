package com.aircamp.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.aircamp.domain.GalleryVO;
import com.aircamp.domain.ItemThumbnailVO;
import com.aircamp.domain.PagingVO;

public interface SearchService {

	// public List<ItemThumbnailVO> searchList(@Param("iAddr") String iAddr,
	// @Param("iSdate") String iSdate, @Param("iEdate") String iEdate,
	// @Param("iTitle") String iTitle) throws Exception;

public List<ItemThumbnailVO> searchList(String iAddr, String iSdate, String iEdate, String iTitle, int pageNum, int amount) throws Exception;
	
	public List<ItemThumbnailVO> getItemThumbnail(Long i_id);
	public GalleryVO getThumnailPhoto(String g_id) ;
	
	// 전체 데이터 수
	public int searchGetTotal(PagingVO paging,String iAddr,String iSdate,String iEdate,String iTitle);
}
