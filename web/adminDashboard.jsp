<%@ page session="true" %>
<%
    // Admin access control
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard - Online Banking</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #cce7ff, #99d1ff); /* pastel blue gradient */
                margin: 0;
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .container {
                max-width: 650px;
                margin: auto;
                background: #ffffff;
                padding: 50px 40px;
                border-radius: 20px;
                box-shadow: 0 15px 30px rgba(0,0,0,0.08);
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .container:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 35px rgba(0,0,0,0.12);
            }

            h2 {
                color: #1e3a8a;
                margin-bottom: 35px;
                font-size: 32px;
                font-weight: 600;
            }

            .btn {
                display: block;
                width: 85%;
                padding: 15px;
                margin: 15px auto;
                background: #1e3a8a;
                color: #fff;
                text-decoration: none;
                font-size: 16px;
                font-weight: 500;
                border-radius: 12px;
                transition: 0.3s;
            }

            .btn:hover {
                background: #162b6d;
                transform: translateY(-2px);
            }

            .logout {
                margin-top: 30px;
                display: inline-block;
                padding: 12px 25px;
                background: #d64545;
                color: #fff;
                border-radius: 12px;
                text-decoration: none;
                font-weight: 500;
                transition: 0.3s;
            }

            .logout:hover {
                background: #a80000;
                transform: translateY(-2px);
            }
        </style>

    </head>
    <body>
        <div class="container">
            <h2>Welcome, <%= session.getAttribute("username")%></h2>

            <a href="addClient.jsp" class="btn">Add Client</a>
            <a href="deleteClient.jsp" class="btn">Delete Client</a>
            <a href="updateClient.jsp" class="btn">Update Client Details</a>
            <a href="viewClients.jsp" class="btn">View Clients & Their Details</a>


            <a href="LogoutServlet" class="logout">Logout</a>

        </div>
    </body>
</html>
