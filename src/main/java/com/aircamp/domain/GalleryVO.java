package com.aircamp.domain;

import org.springframework.stereotype.Component;

import lombok.Data;
@Component
@Data
public class GalleryVO {
	// �ʼ�
	private Long g_id; // seq_gallery_id ���
	private Long i_id;
	private String g_path;
	private String g_uuid;
	private String g_filename;

}
