package com.aircamp.service;

import java.util.List;

import com.aircamp.domain.CommunityVO;
import com.aircamp.domain.PagingVO;

public interface CommunityService {

	// 등록
	public void register(CommunityVO comm);

	// 조회
	public CommunityVO get(Long c_id);

	// 수정
	public boolean modify(CommunityVO comm);

	// 삭제
	public boolean remove(Long c_id);

	// 목록
	//public List<CommunityVO> getList(); 
	public List<CommunityVO> getList(PagingVO paging); 
	
	// 전체 데이터 수
	public int getTotal(PagingVO paging);
	
	// 조회수
	public int updateViewCnt(Long c_id);
}
