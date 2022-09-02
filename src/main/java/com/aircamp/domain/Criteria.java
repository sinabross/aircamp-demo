package com.aircamp.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int pageNum; //���� ��������ȣ
	private int amount;	//�� �������� ����� �� ��

	private String type; //�˻��� �÷�
	private String keyword; //�˻���
	
	public Criteria() {		
		//�Ķ���Ͱ� 2���ִ� ������ ȣ��
		this(1,10);
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	public String[] getTypeArr() {
		//type�� null�̸� String[]�迭�� �����ؼ� ����
		//type�� null�� �ƴϸ� �ѱ��ھ� split�ؼ� ����
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
