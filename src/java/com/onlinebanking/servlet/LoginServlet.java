package com.onlinebanking.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.onlinebanking.util.DBConnection;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String loginType = request.getParameter("loginType"); // "client" or "admin"

        HttpSession session = request.getSession();

        try (Connection conn = DBConnection.getConnection()) {

            PreparedStatement ps;
            ResultSet rs;

            if ("client".equalsIgnoreCase(loginType)) {
                // Fixed password for all clients
                String fixedPassword = "1234";

                // Check if entered password matches the fixed one
                if (!fixedPassword.equals(password)) {
                    request.setAttribute("errorMessage", "Incorrect password. Use the fixed password for clients.");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                    return;
                }

                // Validate client by name
                ps = conn.prepareStatement("SELECT * FROM clients WHERE name=?");
                ps.setString(1, username);
                rs = ps.executeQuery();

                if (rs.next()) {
                    // Client exists, login success
                    session.setAttribute("user_id", rs.getInt("user_id"));
                    session.setAttribute("username", rs.getString("name"));
                    session.setAttribute("role", "client");
                    response.sendRedirect("clientDashboard.jsp");
                } else {
                    // No client record found
                    request.setAttribute("errorMessage", "No client record found with this username.");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                }

            } else if ("admin".equalsIgnoreCase(loginType)) {
                // Validate admin login normally
                ps = conn.prepareStatement("SELECT * FROM admins WHERE username=? AND password=?");
                ps.setString(1, username);
                ps.setString(2, password);
                rs = ps.executeQuery();

                if (rs.next()) {
                    // Admin exists, login success
                    session.setAttribute("admin_id", rs.getInt("admin_id"));
                    session.setAttribute("username", rs.getString("username"));
                    session.setAttribute("role", "admin");
                    response.sendRedirect("adminDashboard.jsp");
                } else {
                    // No admin record found
                    request.setAttribute("errorMessage", "Invalid admin username/password.");
                    RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
                    rd.forward(request, response);
                }

            } else {
                // Invalid loginType
                request.setAttribute("errorMessage", "Invalid login type selected.");
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Something went wrong. Please try again!");
            if ("admin".equalsIgnoreCase(loginType)) {
                RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
                rd.forward(request, response);
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }
        }
    }

    // Optional: forward GET requests to login page
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
