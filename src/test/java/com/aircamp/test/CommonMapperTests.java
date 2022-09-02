package com.aircamp.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.aircamp.mapper.CommonMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CommonMapperTests {
	@Setter(onMethod_=@Autowired)
	private CommonMapper commonMapper;
	
	@Test
	public void testMemberSelect() {
		log.info("============commonMapperTest");
		log.info(commonMapper.commonMapperTest());

	}

}
