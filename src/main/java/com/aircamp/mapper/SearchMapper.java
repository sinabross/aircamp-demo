package com.aircamp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.aircamp.domain.GalleryVO;
import com.aircamp.domain.ItemThumbnailVO;
import com.aircamp.domain.PagingVO;

/*@Mapper*/
public interface SearchMapper {
	
	public List<ItemThumbnailVO> getItemThumbnail(Long i_id);
	
	public List<ItemThumbnailVO> searchResult(@Param("iAddr") String iAddr, @Param("iSdate") String iSdate, @Param("iEdate") String iEdate, @Param("iTitle") String iTitle, @Param("pageNum") int pageNum, @Param("amount") int amount);

	public GalleryVO getThumnailPhoto(@Param("g_id") Long g_id);
	public int searchGetTotal(PagingVO pagingvo,@Param("iAddr") String iAddr, @Param("iSdate") String iSdate, @Param("iEdate") String iEdate, @Param("iTitle") String iTitle);

}
