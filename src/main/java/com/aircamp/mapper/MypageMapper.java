package com.aircamp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.aircamp.domain.CommunityVO;
import com.aircamp.domain.ItemVO;
import com.aircamp.domain.QnaVO;
import com.aircamp.domain.ShareItemVO;
import com.aircamp.domain.ShareVO;

public interface MypageMapper {

		
		//비번체크
		public String pwcheck(String id);
		

		//등록정보 리스트
		public List<ItemVO> mypageItemList(String id);
		
		public List<ItemVO> mypageItemListWithPaging(@Param("m_id") String id ,@Param("pageNum") int pageNum , @Param("amount") int amount);
	 	
		public int mypageItemGetTotalCount(@Param("m_id") String id ,@Param("pageNum") int pageNum , @Param("amount") int amount);
		
		
		//커뮤니티 리스트
		public List<CommunityVO> mypageCommList(String id);
		
		public List<ItemVO> mypageCommListWithPaging(@Param("m_id") String id ,@Param("pageNum") int pageNum , @Param("amount") int amount);
		 	
		public int mypageCommGetTotalCount(@Param("m_id") String id ,@Param("pageNum") int pageNum , @Param("amount") int amount);
			
		//Contactus 리스트
		public List<QnaVO> mypageQnaList(String id);
		
		public List<ItemVO> mypageQnaListWithPaging(@Param("m_id") String id ,@Param("pageNum") int pageNum , @Param("amount") int amount);
	 	
		public int mypageQnaGetTotalCount(@Param("m_id") String id ,@Param("pageNum") int pageNum , @Param("amount") int amount);
		
		//예약정보 리스트
		//public List<ShareItemVO> mypageShareList(String id);
		
		public List<ShareItemVO> mypageShareListWithPaging(@Param("m_id") String m_id ,@Param("pageNum") int pageNum , @Param("amount") int amount);
	 	
		public int mypageShareGetTotalCount(@Param("m_id") String m_id ,@Param("pageNum") int pageNum , @Param("amount") int amount);
		
		
		//예약취소
		public int mypageShareDelete(@Param("m_id") String m_id,@Param("s_id") Long s_id);


		public List<ShareVO> getReservationListByIid(Long i_id);
}
