package com.aircamp.domain;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class ZipcodeVO {
	private Long seq;
	private String zipcode;
	private String sido;
	private String gugun;
	private String dong;
	private String bunji;
}
