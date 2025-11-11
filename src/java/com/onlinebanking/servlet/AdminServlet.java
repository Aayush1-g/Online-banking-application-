package com.onlinebanking.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.onlinebanking.util.DBConnection;

public class AdminServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if(session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String action = request.getParameter("action");

        if("addClient".equalsIgnoreCase(action)) {
            // Get client details from form
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            double balance = Double.parseDouble(request.getParameter("balance"));
            String city = request.getParameter("city");

            try (Connection conn = DBConnection.getConnection()) {
                // Insert into clients table (no password)
                PreparedStatement ps = conn.prepareStatement(
                        "INSERT INTO clients (name, email, balance, city) VALUES (?, ?, ?, ?)"
                );
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setDouble(3, balance);
                ps.setString(4, city);

                int i = ps.executeUpdate();
                if(i > 0) {
                    request.setAttribute("message", "Client successfully added!");
                } else {
                    request.setAttribute("message", "Failed to add client.");
                }

                RequestDispatcher rd = request.getRequestDispatcher("addClient.jsp");
                rd.forward(request, response);

            } catch(Exception e) {
                e.printStackTrace();
                request.setAttribute("message", "Error: " + e.getMessage());
                RequestDispatcher rd = request.getRequestDispatcher("addClient.jsp");
                rd.forward(request, response);
            }
        }

        // You can handle other actions (delete/update clients) here
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
