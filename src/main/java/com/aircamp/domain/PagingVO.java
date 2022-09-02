package com.aircamp.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class PagingVO {

	// 페이징 처리
	private int pageNum;
	private int amount;

	private String type;
	private String keyword;

	public PagingVO() {
		this(1, 10);
	}

	public PagingVO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	// 寃��깋 議곌굔 泥섎━
	public String[] getTypeArr() {

		return type == null ? new String[] {} : type.split("");
	}

	// �뿬�윭媛쒖쓽 �뙆�씪誘명꽣瑜� �뿰寃고빐�꽌 url�쓽 �삎�깭濡� 蹂��솚
	public String getListLink() {

		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("").queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount()).queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());

		return builder.toUriString();

	}

}
