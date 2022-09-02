package com.aircamp.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.aircamp.domain.PagingVO;
import com.aircamp.domain.ReplyVO;

@Mapper
public interface ReplyMapper {
	
	// 등록
	public int insert(ReplyVO vo);
	
	// 조회
	public ReplyVO read(Long r_id);
	
	// 삭제
	public int delete(Long r_id);
	
	// 수정
	public int update(ReplyVO reply);
	
	// 페이지번호
	public List<ReplyVO> getListWithPaging(@Param("paging") PagingVO paging, @Param("c_id") int c_id);

	// 댓글 수
	 public int getCountByC_id(int c_id);
	 
}
