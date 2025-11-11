<%@ page session="true" %>
<%@ page import="java.sql.*, com.onlinebanking.util.DBConnection" %>
<%
    // Check if client is logged in
    if (session == null || !"client".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (int) session.getAttribute("user_id");
    String name = "";
    String email = "";
    double balance = 0;
    String city = "";

    try (Connection conn = DBConnection.getConnection()) {
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM clients WHERE user_id=?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            balance = rs.getDouble("balance");
            city = rs.getString("city");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Client Dashboard - Secure Bank</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #cce7ff, #99d1ff); /* pastel blue gradient */
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .container {
                background: #ffffff;
                padding: 40px 35px;
                border-radius: 15px;
                box-shadow: 0 15px 30px rgba(0,0,0,0.08);
                width: 420px;
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .container:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 35px rgba(0,0,0,0.12);
            }

            h1 {
                color: #1e3a8a;
                margin-bottom: 25px;
                font-weight: 600;
            }

            .details {
                text-align: left;
                margin-top: 20px;
            }

            .details p {
                margin: 10px 0;
                font-size: 16px;
                padding: 8px 12px;
                border-radius: 8px;
                background-color: #f0f8ff; /* soft pastel background */
            }

            .logout {
                margin-top: 25px;
                display: inline-block;
                padding: 12px 25px;
                font-weight: 500;
                border-radius: 10px;
                background-color: #e63946;
                color: #ffffff;
                text-decoration: none;
                transition: 0.3s ease, transform 0.2s ease;
            }

            .logout:hover {
                background-color: #a80000;
                transform: translateY(-2px);
            }
        </style>

    </head>
    <body>
        <div class="container">
            <h1>Bank Details of <%= name%></h1>

            <div class="details">
                <p><strong>User ID:</strong> <%= userId%></p>
                <p><strong>Name:</strong> <%= name%></p>
                <p><strong>Email:</strong> <%= email%></p>
                <p><strong>Balance:</strong> Rs <%= balance%></p>
                <p><strong>City:</strong> <%= city%></p>
            </div>  
            <a href="LogoutServlet" class="logout">Logout</a>
        </div>
    </body>
</html>
