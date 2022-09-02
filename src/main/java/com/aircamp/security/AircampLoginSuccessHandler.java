package com.aircamp.security;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.util.StringUtils;

import lombok.extern.log4j.Log4j;

@Log4j
public class AircampLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication auth) throws IOException, ServletException {
		log.warn("login Success");
		List<String> roleNames=new ArrayList<>();
		auth.getAuthorities().forEach(authority->{
			roleNames.add(authority.getAuthority());
		});
		log.warn("ROLE NAMES: "+roleNames);
		
		if(roleNames.contains("ROLE_MEMBER")||roleNames.contains("ROLE_ADMIN")) {
			response.setContentType("json");
			response.setCharacterEncoding("utf-8");
			
			String data= "{\"message\":\"success\"}";
			PrintWriter out = response.getWriter();
			out.print(data);
			out.flush();
			out.close();
		}

	}

}
