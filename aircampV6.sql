
/* Drop Tables */

DROP TABLE TBL_REPLY CASCADE CONSTRAINTS;
DROP TABLE TBL_COMMUNITY CASCADE CONSTRAINTS;
DROP TABLE TBL_GALLERY CASCADE CONSTRAINTS;
DROP TABLE TBL_SHARE CASCADE CONSTRAINTS;
DROP TABLE TBL_ITEM CASCADE CONSTRAINTS;
DROP TABLE tbl_member_auth CASCADE CONSTRAINTS;
DROP TABLE TBL_QNA CASCADE CONSTRAINTS;
DROP TABLE TBL_MEMBER CASCADE CONSTRAINTS;
DROP TABLE ZIPCODE CASCADE CONSTRAINTS;




/* Create Tables */

CREATE TABLE TBL_COMMUNITY
(
	-- seq_comm_id 사용
	c_id number NOT NULL,
	m_id varchar2(20) NOT NULL,
	c_title varchar2(50) NOT NULL,
	c_content varchar2(2000) NOT NULL,
	c_regdate date DEFAULT SYSDATE NOT NULL,
	c_read_cnt number DEFAULT 0 NOT NULL,
	PRIMARY KEY (c_id)
);


CREATE TABLE TBL_GALLERY
(
	-- seq_gallery_id 사용
	g_id number NOT NULL,
	-- seq_item_id 시퀀스로 사용한다
	i_id number NOT NULL,
	g_uuid varchar2(100) NOT NULL,
	g_path varchar2(200) NOT NULL,
	g_filename varchar2(100) NOT NULL,
	PRIMARY KEY (g_id)
);


CREATE TABLE TBL_ITEM
(
	-- seq_item_id 시퀀스로 사용한다
	i_id number NOT NULL,
	-- 멤버테이블의 아이디의 참조키
	m_id varchar2(20) NOT NULL,
	i_sdate varchar2(20) NOT NULL,
	i_edate varchar2(20) NOT NULL,
	i_score number DEFAULT 0 NOT NULL,
	i_eval number DEFAULT 0 NOT NULL,
	-- 아이템 수정시 등록일 변경불가
	i_regdate date DEFAULT SYSDATE NOT NULL,
	i_title varchar2(50) NOT NULL,
	i_price number NOT NULL,
	i_info varchar2(2000) NOT NULL,
	i_phone varchar2(13) NOT NULL,
	i_email varchar2(30),
	i_katalk varchar2(20),
	i_addr varchar2(50) NOT NULL,
	-- 0 = 아이템 삭제하지 않았을 경우
	-- 1 = 아이템 삭제했을 경우
	i_status number(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (i_id)
);


CREATE TABLE TBL_MEMBER
(
	m_id varchar2(20) NOT NULL,
	m_name varchar2(20) NOT NULL,
	m_pw varchar2(200) NOT NULL,
	m_phone varchar2(13) NOT NULL,
	m_email varchar2(30),
	m_katalk varchar2(20),
	m_uuid varchar2(100),
	m_path varchar2(200),
	m_filename varchar2(100),
	m_score number DEFAULT 0 NOT NULL,
	m_eval number DEFAULT 0 NOT NULL,
	-- 0 = 탈퇴하지 않은 회원
	-- 1 = 탈퇴한 회원
	m_status number(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (m_id)
);


CREATE TABLE TBL_MEMBER_AUTH
(
	m_id varchar2(20) NOT NULL,
	auth varchar2(20) DEFAULT 'ROLE_MEMBER' NOT NULL,
	PRIMARY KEY (m_id)
);


CREATE TABLE TBL_QNA
(
	-- seq_qna_id 사용
	q_id number NOT NULL,
	m_id varchar2(20) NOT NULL,
	q_email varchar2(30) NOT NULL,
	q_title varchar2(50) NOT NULL,
	q_content varchar2(2000) NOT NULL,
	q_regdate date DEFAULT SYSDATE NOT NULL,
	PRIMARY KEY (q_id)
);


CREATE TABLE TBL_REPLY
(
	-- seq_reply_id 사용
	r_id number NOT NULL,
	-- seq_comm_id 사용
	c_id number NOT NULL,
	m_id varchar2(20) NOT NULL,
	r_content varchar2(1000) NOT NULL,
	r_regdate date DEFAULT SYSDATE NOT NULL,
	PRIMARY KEY (r_id)
);


CREATE TABLE TBL_SHARE
(
	-- seq_share_id 시퀀스 사용
	s_id number NOT NULL,
	-- seq_item_id 시퀀스로 사용한다
	i_id number NOT NULL,
	m_id varchar2(20) NOT NULL,
	s_sdate varchar2(20) NOT NULL,
	s_edate varchar2(20) NOT NULL,
	s_price number NOT NULL,
	s_addr varchar2(50) NOT NULL,
	s_regdate date DEFAULT SYSDATE NOT NULL,
	-- 
	-- 
	s_opi varchar2(2000),
	s_opidate date DEFAULT SYSDATE,
	s_score_m number DEFAULT 0,
	s_score_i number DEFAULT 0,
	-- 0 = 후기작성안함
	-- 1 = 후기작성함
	-- 
	s_opi_chk number(1) DEFAULT 0 NOT NULL,
	PRIMARY KEY (s_id)
);


CREATE TABLE ZIPCODE
(
	seq number(5) NOT NULL,
	zipcode varchar2(7),
	sido varchar2(50),
	gugun varchar2(100),
	dong varchar2(300),
	bunji varchar2(300),
	PRIMARY KEY (seq)
);



/* Create Foreign Keys */

ALTER TABLE TBL_REPLY
	ADD FOREIGN KEY (c_id)
	REFERENCES TBL_COMMUNITY (c_id)
;


ALTER TABLE TBL_GALLERY
	ADD FOREIGN KEY (i_id)
	REFERENCES TBL_ITEM (i_id)
;


ALTER TABLE TBL_SHARE
	ADD FOREIGN KEY (i_id)
	REFERENCES TBL_ITEM (i_id)
;


ALTER TABLE TBL_COMMUNITY
	ADD FOREIGN KEY (m_id)
	REFERENCES TBL_MEMBER (m_id)
;


ALTER TABLE TBL_ITEM
	ADD FOREIGN KEY (m_id)
	REFERENCES TBL_MEMBER (m_id)
;


ALTER TABLE tbl_member_auth
	ADD FOREIGN KEY (m_id)
	REFERENCES TBL_MEMBER (m_id)
;


ALTER TABLE TBL_QNA
	ADD FOREIGN KEY (m_id)
	REFERENCES TBL_MEMBER (m_id)
;


ALTER TABLE TBL_REPLY
	ADD FOREIGN KEY (m_id)
	REFERENCES TBL_MEMBER (m_id)
;


ALTER TABLE TBL_SHARE
	ADD FOREIGN KEY (m_id)
	REFERENCES TBL_MEMBER (m_id)
;



/* Comments */

COMMENT ON COLUMN TBL_COMMUNITY.c_id IS 'seq_comm_id 사용';
COMMENT ON COLUMN TBL_GALLERY.g_id IS 'seq_gallery_id 사용';
COMMENT ON COLUMN TBL_GALLERY.i_id IS 'seq_item_id 시퀀스로 사용한다';
COMMENT ON COLUMN TBL_ITEM.i_id IS 'seq_item_id 시퀀스로 사용한다';
COMMENT ON COLUMN TBL_ITEM.m_id IS '멤버테이블의 아이디의 참조키';
COMMENT ON COLUMN TBL_ITEM.i_regdate IS '아이템 수정시 등록일 변경불가';
COMMENT ON COLUMN TBL_ITEM.i_status IS '0 = 아이템 삭제하지 않았을 경우
1 = 아이템 삭제했을 경우';
COMMENT ON COLUMN TBL_MEMBER.m_status IS '0 = 탈퇴하지 않은 회원
1 = 탈퇴한 회원';
COMMENT ON COLUMN TBL_QNA.q_id IS 'seq_qna_id 사용';
COMMENT ON COLUMN TBL_REPLY.r_id IS 'seq_reply_id 사용';
COMMENT ON COLUMN TBL_REPLY.c_id IS 'seq_comm_id 사용';
COMMENT ON COLUMN TBL_SHARE.s_id IS 'seq_share_id 시퀀스 사용';
COMMENT ON COLUMN TBL_SHARE.i_id IS 'seq_item_id 시퀀스로 사용한다';
COMMENT ON COLUMN TBL_SHARE.s_opi IS '
';
COMMENT ON COLUMN TBL_SHARE.s_opi_chk IS '0 = 후기작성안함
1 = 후기작성함
';



