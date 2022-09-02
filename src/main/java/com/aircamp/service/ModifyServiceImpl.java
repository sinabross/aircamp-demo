package com.aircamp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aircamp.domain.GalleryVO;
import com.aircamp.domain.ItemVO;
import com.aircamp.mapper.AddFileMapper;
import com.aircamp.mapper.ModifyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ModifyServiceImpl implements ModifyService{
	
	@Setter(onMethod_= @Autowired)
	private ModifyMapper modifyMapper;
	@Setter(onMethod_= @Autowired)
	private AddFileMapper addFileMapper;
	
	@Override
	public ItemVO getItem(ItemVO item) {
		
		System.out.println("수정서비스불러오기" + item);
		
		return modifyMapper.addByIid(item);
	}
	
	@Override
	public List<GalleryVO> getGalleryList(GalleryVO gVO) {
		
		log.info("수정갤러리불러오기" + gVO);
		
		return modifyMapper.fileByIid(gVO);
	}
	
	@Transactional
	@Override
	public boolean updateItem(ItemVO item) {
		
		log.info(item);
		
		modifyMapper.deleteAll(item);
		
		boolean modifyResult = modifyMapper.updateItem(item)== 1;
		
		if (modifyResult == true) {
			item.getGalleryList().forEach(attach ->{
				
				attach.setI_id(item.getI_id());
				addFileMapper.insert(attach);
				
			});
		}
		
		return modifyResult;
	}

	@Override
	public ItemVO detailRemove(ItemVO item) {
		
		modifyMapper.detailRemove(item);
		
		return null;
	}
	
	
}
