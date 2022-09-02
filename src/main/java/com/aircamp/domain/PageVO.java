package com.aircamp.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageVO {

	// 페이지에 페이징 처리
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private PagingVO paging;
	
	public PageVO(PagingVO paging, int total) {
		
		this.paging = paging;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(paging.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		int realEnd = (int)(Math.ceil((total * 1.0) / paging.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}
}
