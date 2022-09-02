package com.aircamp.security;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class AircampLoginDeniedHandler implements AuthenticationFailureHandler{@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		log.warn("login denied");
		
		log.warn("======: "+exception.getLocalizedMessage());
		if(exception.getLocalizedMessage()==null) {
			response.setContentType("json");
			response.setCharacterEncoding("utf-8");
			String data= "{\"message\":\"fail\", \"reason\":\"nomember\"}";
			PrintWriter out = response.getWriter();
			out.print(data);
			out.flush();
			out.close();
		}
		if(exception.getLocalizedMessage()=="Bad credentials") {
			response.setContentType("json");
			response.setCharacterEncoding("utf-8");
			String data= "{\"message\":\"fail\",\"reason\":\"wrongpass\"}";
			PrintWriter out = response.getWriter();
			out.print(data);
			out.flush();
			out.close();
		}
		// TODO Auto-generated method stub
		//userNotFoundPassword
		
	}
	

}
