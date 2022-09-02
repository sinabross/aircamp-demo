package com.aircamp.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.aircamp.domain.MemberVO;

import lombok.Getter;

@Getter

public class AircampUserDetails extends User {

	private MemberVO member;
	public AircampUserDetails(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
		// TODO Auto-generated constructor stub
	}
	
	public AircampUserDetails(MemberVO vo) {
		super(vo.getM_id(), vo.getM_pw(), vo.getM_authList().stream().map(auth->new SimpleGrantedAuthority(auth.getAuth())).collect(Collectors.toList()));
		this.member=vo;
	}
}
