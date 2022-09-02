package com.aircamp.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ItemThumbnailVO {
	// item내용
	private Long i_id;// seq_item_id
	private String m_id;
	private String i_sdate;
	private String i_edate;
	private int i_score;
	private int i_eval;
	private Date i_regdate;
	private String i_title;
	private int i_price;
	private String i_info;
	private String i_phone;

	private String i_email;
	private String i_katalk;

	private String i_addr;
	private int i_status;
	private Long g_id;

	/*
	 * //썸네일용 사진 1개만 private String g_path; private String g_uuid; private String
	 * g_filename;
	 */
}
