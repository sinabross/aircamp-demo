package com.aircamp.service;

import java.util.List;

import com.aircamp.domain.PagingVO;
import com.aircamp.domain.ReplyPageVO;
import com.aircamp.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public ReplyVO get(Long r_id);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long r_id);
	
	public List<ReplyVO> getList(PagingVO paging, int c_id);
	
	
	 // 댓글 수
	public ReplyPageVO getListPage(PagingVO paging, int c_id);


	 


}
