package com.aircamp.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aircamp.domain.MemberVO;
import com.aircamp.mapper.ItemMapper;
import com.aircamp.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor

public class MemberServiceImpl implements MemberService {

	private PasswordEncoder pwencoder;
	private MemberMapper memberMapper;
	private ItemMapper itemMapper;
	// private CommonMapper commonMapper;

	@Override
	@Transactional
	public void memberjoin(MemberVO member) {
		String encodedPw;
		encodedPw = member.getM_pw();
		member.setM_pw(pwencoder.encode(encodedPw));
		log.info("memberjoin......" + member);

		memberMapper.memberjoin(member);
		log.info("idcheck......" + member.getM_id());

		memberMapper.memberjoinAuth(member);

	}

	@Override
	public Integer idcheck(String id) {

		log.info("idcheck......" + id);

		return memberMapper.idcheck(id);

	}

	@Override
	public MemberVO idread(String id) {

		log.info("idread...." + id);

		return memberMapper.idread(id);

	}

	@Override
	@Transactional
	public boolean memberupdate(MemberVO member) {

		String encodedPw;
		encodedPw = member.getM_pw();
		member.setM_pw(pwencoder.encode(encodedPw));

		return memberMapper.memberupdate(member) == 1;
	}
	@Transactional
	@Override
	public boolean memberdelete(String id) {

		log.info("memberdelete......" + id);

		itemMapper.deleteMemberItem(id);
		
		return memberMapper.memberdelete(id) == 1;
	}

	@Override
	public String findId(MemberVO vo) {
		// TODO Auto-generated method stub

		log.info("findId......" + vo.getM_name() + " " + vo.getM_phone());

		memberMapper.findId(vo);
		return memberMapper.findId(vo);
	}

	@Override
	public String findPw(MemberVO vo) {
		// TODO Auto-generated method stub

		log.info("findPw......" + vo.getM_id() + " " + vo.getM_phone());

		memberMapper.findPw(vo);
		return memberMapper.findPw(vo);
	}

}
