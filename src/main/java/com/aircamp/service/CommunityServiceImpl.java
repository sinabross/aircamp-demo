package com.aircamp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aircamp.domain.CommunityVO;
import com.aircamp.domain.PagingVO;
import com.aircamp.mapper.CommunityMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
@AllArgsConstructor
public class CommunityServiceImpl implements CommunityService {


	@Setter(onMethod_=@Autowired)
	private CommunityMapper mapper;
	
	// 등록
	@Override
	public void register(CommunityVO comm) {
		
		log.info("register==============" + comm);
		
		mapper.insertSelectKey(comm);
	}

	// 조회
	@Override
	public CommunityVO get(Long c_id) {
		
		log.info("get============"+c_id);
		
		return mapper.read(c_id);
	}

	// 수정
	@Override
	public boolean modify(CommunityVO comm) {

		log.info("modify=========="+comm);
		
		return mapper.update(comm) == 1;
	}

	// 삭제
	@Override
	public boolean remove(Long c_id) {
		
		log.info("remove==========="+c_id);
		return mapper.delete(c_id) == 1;
	}

	// 목록
	/*
	 * @Override public List<CommunityVO> getList() {
	 * 
	 * log.info("getList================"); return mapper.getList(); }
	 */
	
	@Override
	public List<CommunityVO> getList(PagingVO paging) {
		
		log.info("getListPage================"+paging);
		
		return mapper.getListWithPaging(paging);
	}

	@Override
	public int getTotal(PagingVO paging) {
		
		log.info("get Total count");
		
		return mapper.getTotalCount(paging);
	}

	@Override
	public int updateViewCnt(Long c_id) {
		
		return mapper.updateViewCnt(c_id);
		
	}

}
