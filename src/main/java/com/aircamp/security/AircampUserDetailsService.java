package com.aircamp.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.aircamp.domain.MemberVO;
import com.aircamp.mapper.CommonMapper;
import com.aircamp.security.domain.AircampUserDetails;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class AircampUserDetailsService implements UserDetailsService{
	@Setter(onMethod_ = {@Autowired})
	private CommonMapper commonMapper;
	
	
	@Override
	public UserDetails loadUserByUsername(String m_id) throws UsernameNotFoundException {
		// user의 상세정보를 리턴
		log.warn("Load User By UserName: "+ m_id);
//		log.warn("Load User By UserName: "+ m_pw);

		MemberVO vo= commonMapper.login(m_id);

		log.warn("===============memberVO: "+vo);

		log.warn("===============memberVO: "+vo.getM_name());
		log.warn("===============memberVO: "+vo.getM_pw());

		
		return vo == null? null : new AircampUserDetails(vo);
	}

}
