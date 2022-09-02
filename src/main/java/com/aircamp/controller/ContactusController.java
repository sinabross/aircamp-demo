package com.aircamp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.aircamp.domain.QnaVO;
import com.aircamp.service.ContactusService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/contactus")
@AllArgsConstructor
@Log4j
public class ContactusController {

	private ContactusService contactusService;

	@GetMapping("")
	public String getContactUs() {
		log.info("/contactus get");
		return "/contactus/contactus";
	}

	@PostMapping("")
	public String postContactUs(QnaVO qna) {
		log.info("/contactus post : " + qna);

		int resultInsertQna = contactusService.insertQna(qna);

		if (resultInsertQna != 1) {
			log.info("========insertQna실패");
			return "redirect:contactus/fail?";

		} else {
			log.info("/contactus post : " + qna);
			// rttr.addFlashAttribute("result","OK");

			return "redirect:contactus/success?q_id=" + qna.getQ_id();
		}

	}

	@GetMapping("/success")
	public void successContactUs(@RequestParam("q_id") String q_id,Model model) {
		log.info("/contactus/success : " + q_id);
		model.addAttribute("qna", contactusService.getQna(q_id));
		log.info("qna: " + contactusService.getQna(q_id));
	}

}
