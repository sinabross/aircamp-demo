package com.aircamp.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.aircamp.domain.ItemVO;
import com.aircamp.domain.ShareItemVO;
import com.aircamp.domain.ShareVO;
import com.aircamp.mapper.MypageMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MypageServiceimpl implements MypageService {

	private MypageMapper mapper;

	@Override
	public String pwcheck(String id) {
		log.info("Mypage_pwcheck........");
		return mapper.pwcheck(id);
	}
	/*
	 * @Override public List<ItemVO> mypageItemList(String id) {
	 * log.info("Mypage_ItemList.......");
	 * 
	 * return mapper.mypageItemList(id); }
	 * 
	 * @Override public List<CommunityVO> mypageCommList(String id) {
	 * log.info("Mypage_CommList.......");
	 * 
	 * return mapper.mypageCommList(id); }
	 * 
	 * @Override public List<QnaVO> mypageQnaList(String id) {
	 * log.info("Mypage_QnaList.......");
	 * 
	 * return mapper.mypageQnaList(id); }
	 * 
	 * @Override public List<ShareItemVO> mypageShareList(String id) {
	 * log.info("Mypage_ShareList........."); return mapper.mypageShareList(id); }
	 */

	@Override
	public List<ItemVO> mypageItemWithPaging(String id, int pageNum, int amount) {
		log.info("Mypage_ItemList..........");
		return mapper.mypageItemListWithPaging(id, pageNum, amount);
	}

	@Override
	public int mypageItemGetTotalCount(String id, int pageNum, int amount) {
		log.info("Mypage_Item_TOtal");
		return mapper.mypageItemGetTotalCount(id, pageNum, amount);
	}

	@Override
	public List<ItemVO> mypageCommListWithPaging(String id, int pageNum, int amount) {
		log.info("Mypage_CommList..............");
		return mapper.mypageCommListWithPaging(id, pageNum, amount);
	}

	@Override
	public int mypageCommGetTotalCount(String id, int pageNum, int amount) {
		log.info("Mypage_Comm_TOtal");
		return mapper.mypageCommGetTotalCount(id, pageNum, amount);
	}

	@Override
	public List<ItemVO> mypageQnaListWithPaging(String id, int pageNum, int amount) {
		log.info("Mypage_QnaList................");
		return mapper.mypageQnaListWithPaging(id, pageNum, amount);
	}

	@Override
	public int mypageQnaGetTotalCount(String id, int pageNum, int amount) {
		log.info("Mypage_Qna_Total.......");
		return mapper.mypageQnaGetTotalCount(id, pageNum, amount);
	}

//	@Override
//	public List<ShareItemVO> mypageShareList(String id) {
//			log.info("Mypage_ShareList.........");
//		return mapper.mypageShareList(id);
//	}

	@Override
	public boolean mypageShareDelete(String m_id, Long s_id) {
		return mapper.mypageShareDelete(m_id,s_id) == 1;

	}

	@Override
	public List<ShareItemVO> mypageShareList(String m_id, int pageNum, int amount) {
		return mapper.mypageShareListWithPaging(m_id, pageNum, amount);
	}

	@Override
	public int mypageShareGetTotalCount(String m_id, int pageNum, int amount) {
		return mapper.mypageShareGetTotalCount(m_id, pageNum, amount);
	}

	@Override
	public List<ShareVO> getReservationListByIid(Long i_id) {
		// TODO Auto-generated method stub
		return mapper.getReservationListByIid(i_id);
	}

}
