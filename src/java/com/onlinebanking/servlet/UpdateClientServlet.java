package com.onlinebanking.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.onlinebanking.util.DBConnection;

public class UpdateClientServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if(session == null || !"admin".equals(session.getAttribute("role"))){
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            int userId = Integer.parseInt(request.getParameter("user_id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            double balance = Double.parseDouble(request.getParameter("balance"));
            String city = request.getParameter("city");

            PreparedStatement ps = conn.prepareStatement(
                    "UPDATE clients SET name=?, email=?, balance=?, city=? WHERE user_id=?"
            );
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setDouble(3, balance);
            ps.setString(4, city);
            ps.setInt(5, userId);

            int i = ps.executeUpdate();
            if(i > 0){
                session.setAttribute("updateMessage", "Client details updated successfully!");
            } else {
                session.setAttribute("updateMessage", "Failed to update client.");
            }

            response.sendRedirect("updateClient.jsp");

        } catch(Exception e){
            e.printStackTrace();
            session.setAttribute("updateMessage", "Error: " + e.getMessage());
            response.sendRedirect("updateClient.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
