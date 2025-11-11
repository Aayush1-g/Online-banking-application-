package com.onlinebanking.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // get existing session
        if(session != null){
            session.invalidate(); // destroy session
        }

        response.sendRedirect("login.jsp"); // redirect to client login page
    }
}
