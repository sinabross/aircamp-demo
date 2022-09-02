package com.aircamp.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum; //현재 페이지번호
	private int amount;	//한 페이지에 출력할 글 수

	private String type; //검색할 컬럼
	private String keyword; //검색어
	
	public Criteria() {		
		//파라미터가 2개있는 생성자 호출
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		//type이 null이면 String[]배열을 생성해서 리턴
		//type이 null이 아니면 한글자씩 split해서 리턴
		return type==null ? new String[] {} : type.split("");
	}
	
	public String getListLink() {
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.amount)
				.queryParam("type", this.type)
				.queryParam("keyword", this.keyword);
		
		return builder.toUriString();
	}
}
