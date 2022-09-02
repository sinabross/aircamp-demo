package com.aircamp.security;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class AircampLogoutSuccessHandler implements LogoutSuccessHandler {

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		log.warn("Logout");

		
			response.setContentType("json");
			response.setCharacterEncoding("utf-8");
			String data = "{\"message\":\"로그아웃 되었습니다.\"}";
			PrintWriter out = response.getWriter();
			out.print(data);
			out.flush();
			out.close();
		

	}

}
