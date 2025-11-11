<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Login - Secure Bank</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #cce7ff, #99d1ff); /* pastel blue gradient */
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            h1 {
                color: #1e3a8a; /* dark blue */
                margin-bottom: 25px;
                font-size: 36px;
                font-weight: 600;
                letter-spacing: 1px;
            }

            .login-container {
                background-color: #ffffff;
                padding: 40px 35px;
                border-radius: 15px;
                box-shadow: 0 15px 30px rgba(0,0,0,0.08);
                width: 320px;
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .login-container:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 35px rgba(0,0,0,0.12);
            }

            .login-container h2 {
                color: #1e3a8a; /* dark blue */
                margin-bottom: 20px;
                font-weight: 500;
            }

            input[type=text], input[type=password] {
                width: 90%;
                padding: 12px;
                margin: 12px 0;
                border-radius: 10px;
                border: 1px solid #d0d6db;
                background-color: #f0f8ff; /* soft pastel input */
                font-size: 14px;
                outline: none;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }

            input[type=text]:focus, input[type=password]:focus {
                border-color: #1e3a8a; /* dark blue focus */
                box-shadow: 0 0 8px rgba(30,58,138,0.3);
            }

            input[type=submit] {
                width: 95%;
                padding: 12px;
                margin-top: 15px;
                background-color: #1e3a8a; /* dark blue button */
                color: #fff;
                border: none;
                border-radius: 10px;
                font-size: 15px;
                font-weight: 500;
                cursor: pointer;
                transition: background 0.3s ease, transform 0.2s ease;
            }

            input[type=submit]:hover {
                background-color: #162b6d; /* darker shade on hover */
                transform: translateY(-2px);
            }

            .error {
                color: #d63031;
                margin-top: 12px;
                font-weight: 500;
                font-size: 14px;
            }

            a {
                display: block;
                margin-top: 18px;
                color: #1e3a8a;
                text-decoration: none;
                font-weight: 500;
                transition: color 0.3s ease;
            }

            a:hover {
                color: #162b6d;
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <h1>Secure Bank</h1>

        <div class="login-container">
            <h2>Admin Login</h2>

            <!-- Login Form -->
            <form action="LoginServlet" method="post">
                <input type="hidden" name="loginType" value="admin">
                <input type="text" name="username" placeholder="Username" required><br>
                <input type="password" name="password" placeholder="Password" required><br>
                <input type="submit" value="Login">
            </form>

            <!-- Error message -->
            <% if (request.getAttribute("errorMessage") != null) {%>
            <div class="error"><%= request.getAttribute("errorMessage")%></div>
            <% }%>

            <a href="login.jsp">Login as Client</a>
        </div>
    </body>
</html>
