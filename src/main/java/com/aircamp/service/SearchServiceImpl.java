package com.aircamp.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.aircamp.domain.GalleryVO;
import com.aircamp.domain.ItemThumbnailVO;
import com.aircamp.domain.PagingVO;
import com.aircamp.mapper.SearchMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j

public class SearchServiceImpl implements SearchService {

	@Resource(name = "searchMapper")
	private SearchMapper searchMapper;

	/*
	 * @Override public List<ItemThumbnailVO> searchList(@Param("iAddr") String
	 * iAddr, @Param("iSdate") String iSdate,
	 * 
	 * @Param("iEdate") String iEdate, @Param("iTitle") String iTitle) throws
	 * Exception { log.info("getList=======================================");
	 * log.info("二쇱냼" + iAddr); log.info("���뿬�씪" + iSdate); log.info("諛섎궔�씪" +
	 * iEdate); log.info("�젣紐�" + iTitle); log.info("========================" +
	 * searchMapper.searchResult(iAddr, iSdate, iEdate, iTitle)); return
	 * searchMapper.searchResult(iAddr, iSdate, iEdate, iTitle); }
	 */

	@Override
	public List<ItemThumbnailVO> getItemThumbnail(Long i_id) {
		log.info("�븘�씠�뀥 �븘�씠�뵒" + i_id);
		log.info("================================" + searchMapper.getItemThumbnail(i_id));

		return searchMapper.getItemThumbnail(i_id);
	}

	@Override
	public GalleryVO getThumnailPhoto(String g_id) {
		log.info("媛ㅻ윭由� �븘�씠�뵒" + g_id);

		log.info("================================" + searchMapper.getThumnailPhoto(Long.parseLong(g_id)));

		return searchMapper.getThumnailPhoto(Long.parseLong(g_id));
	}

	@Override
	public List<ItemThumbnailVO> searchList(String iAddr, String iSdate, String iEdate, String iTitle, int pageNum,
			int amount) throws Exception {

		log.info(
				"========================" + searchMapper.searchResult(iAddr, iSdate, iEdate, iTitle, pageNum, amount));
		return searchMapper.searchResult(iAddr, iSdate, iEdate, iTitle, pageNum, amount);
	}

	/*
	 * @Override public List<ItemThumbnailVO> searchResult(String iAddr, String
	 * iSdate, String iEdate, String iTitle, int pageNum, int amount) { // TODO
	 * Auto-generated method stub return null; }
	 */
	

	@Override
	public int searchGetTotal(PagingVO paging, String iAddr, String iSdate, String iEdate, String iTitle) {
		log.info("get Total count");

		return searchMapper.searchGetTotal(paging, iAddr, iSdate, iEdate, iTitle);
	}

}
