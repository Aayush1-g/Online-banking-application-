package com.onlinebanking.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.onlinebanking.util.DBConnection;

public class DeleteClientServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if(session == null || !"admin".equals(session.getAttribute("role"))){
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {

            int userId = Integer.parseInt(request.getParameter("user_id"));

            PreparedStatement ps = conn.prepareStatement(
                    "DELETE FROM clients WHERE user_id=?"
            );
            ps.setInt(1, userId);

            int i = ps.executeUpdate();
            if(i > 0){
                session.setAttribute("deleteMessage", "Client deleted successfully!");
            } else {
                session.setAttribute("deleteMessage", "Failed to delete client.");
            }

            response.sendRedirect("deleteClient.jsp");

        } catch(Exception e){
            e.printStackTrace();
            session.setAttribute("deleteMessage", "Error: " + e.getMessage());
            response.sendRedirect("deleteClient.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
