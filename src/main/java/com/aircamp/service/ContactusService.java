package com.aircamp.service;

import com.aircamp.domain.QnaVO;

public interface ContactusService {
	public int insertQna(QnaVO qvo);

	public QnaVO getQna(String q_id);
}
