package com.aircamp.service;

import org.springframework.stereotype.Service;

import com.aircamp.domain.QnaVO;
import com.aircamp.mapper.ContactusMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ContactusServiceImpl implements ContactusService {
	ContactusMapper contactusMapper;

	@Override
	public int insertQna(QnaVO qvo) {

		log.info("ContactusServiceImpl - insertQna" + qvo);

		int insertResult = contactusMapper.insertQna(qvo);

		return insertResult;

	}

	@Override
	public QnaVO getQna(String q_id) {
		log.info("ContactusServiceImpl - getQna" + q_id);
		
		
		return contactusMapper.getQna(q_id);
	}

}
