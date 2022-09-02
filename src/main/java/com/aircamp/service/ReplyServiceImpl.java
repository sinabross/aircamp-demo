package com.aircamp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.aircamp.domain.PagingVO;
import com.aircamp.domain.ReplyPageVO;
import com.aircamp.domain.ReplyVO;
import com.aircamp.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService {

	@Setter(onMethod_=@Autowired)
	private ReplyMapper replymapper;
	
	@Override
	public int register(ReplyVO vo) {

		log.info("register==============================");
		
		return replymapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long r_id) {
		
		log.info("get=================================");
		
		return replymapper.read(r_id);
	}

	@Override
	public int modify(ReplyVO vo) {
		
		log.info("modify==============================");
		
		return replymapper.update(vo);
	}

	@Override
	public int remove(Long r_id) {
		
		log.info("remove===============================");
		
		return replymapper.delete(r_id);
	}

	@Override
	public List<ReplyVO> getList(PagingVO paging, int c_id) {
		
		log.info("get Reply List of a Comm :"+c_id);
		
		return replymapper.getListWithPaging(paging, c_id);
	}

	@Override
	public ReplyPageVO getListPage(PagingVO paging, int c_id) {
		
		return new ReplyPageVO(
			replymapper.getCountByC_id(c_id),
			replymapper.getListWithPaging(paging, c_id));
	}

}
