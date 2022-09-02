package com.aircamp.mapper;

import org.apache.ibatis.annotations.Param;

import com.aircamp.domain.QnaVO;

public interface ContactusMapper {

	public int insertQna(QnaVO qvo);

	public QnaVO getQna(@Param("q_id") String q_id);
}
