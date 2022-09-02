package com.aircamp.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.aircamp.domain.ItemVO;
import com.aircamp.mapper.AddFileMapper;
import com.aircamp.mapper.AddMapper;
import com.aircamp.mapper.ContactusMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AddServiceImpl implements AddService{


	@Setter(onMethod_= @Autowired)
	private AddMapper addMapper;
	
	@Setter(onMethod_= @Autowired)
	private AddFileMapper addFileMapper;
	
	@Transactional
	@Override
	public void register(ItemVO item) {
		
		addMapper.insert(item);
		log.info("addServiceImpl");
		if (item.getGalleryList() == null || item.getGalleryList().size() <= 0) {
			return;
		}
		
		item.getGalleryList().forEach(attach ->{
			
			attach.setI_id(item.getI_id());
			
			addFileMapper.insert(attach);
		});
		
	}

}
