package com.aircamp.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.aircamp.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SampleTests {
	
	private TestVO testVO;
	
	@Test
	public void testExist() {
		System.out.println("===================");

		System.out.println(testVO);
	
		log.info("===================");		
		log.info(testVO);

	}

}
