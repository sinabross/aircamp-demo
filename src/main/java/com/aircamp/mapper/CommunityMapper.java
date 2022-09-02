package com.aircamp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.aircamp.domain.CommunityVO;
import com.aircamp.domain.PagingVO;

@Mapper
public interface CommunityMapper {

	public List<CommunityVO> getList();
	
	public void insert(CommunityVO comm);
	
	public void insertSelectKey(CommunityVO comm);
	
	public CommunityVO read(Long c_id);
	
	public int delete(Long c_id);
	
	public int update(CommunityVO comm);
	
	public List<CommunityVO> getListWithPaging(PagingVO paging);
	
	// 전체 데이터 개수 처리
	public int getTotalCount(PagingVO paging);
	
	// 조회수
	public int updateViewCnt(Long c_id);

	
}
