package com.aircamp.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ReviewPageDTO {
	private int reviewCnt;
	private List<ShareMemberVO> reviewList;
}
