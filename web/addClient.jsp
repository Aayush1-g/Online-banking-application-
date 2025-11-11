<%@ page session="true" %>
<%
    // Admin access control
    if(session == null || !"admin".equals(session.getAttribute("role"))){
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Add Client - Online Banking</title>
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
                width: 360px;
                text-align: center;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .container:hover {
                transform: translateY(-5px);
                box-shadow: 0 20px 35px rgba(0,0,0,0.12);
            }

            h2 {
                color: #1e3a8a;
                margin-bottom: 25px;
                font-weight: 600;
            }

            input[type=text], input[type=number] {
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

            input[type=text]:focus, input[type=number]:focus {
                border-color: #1e3a8a;
                box-shadow: 0 0 8px rgba(30,58,138,0.3);
            }

            input[type=submit], .back {
                display: inline-block;
                width: 48%; /* equal size */
                padding: 12px 0;
                margin: 12px 1%;
                font-size: 15px;
                font-weight: 500;
                border-radius: 10px;
                text-decoration: none;
                cursor: pointer;
                transition: 0.3s ease, transform 0.2s ease;
            }

            input[type=submit] {
                background-color: #1e3a8a;
                color: #fff;
                border: none;
            }

            input[type=submit]:hover {
                background-color: #162b6d;
                transform: translateY(-2px);
            }

            .back {
                background-color: #a8dadc;
                color: #1d3557;
                border: none;
                text-align: center;
                line-height: 1.4;
            }

            .back:hover {
                background-color: #457b9d;
                color: #fff;
                transform: translateY(-2px);
            }
        </style>

    </head>
    <body>
        <div class="container">
            <h2>Add New Client</h2>
            <form action="AdminServlet" method="post">
                <input type="hidden" name="action" value="addClient">

                Name: <input type="text" name="name" placeholder="Full Name" required><br>
                Email: <input type="text" name="email" placeholder="Email Address" required><br>
                Balance: <input type="number" name="balance" placeholder="Initial Balance" required><br>
                City: <input type="text" name="city" placeholder="City" required><br>

                <input type="submit" value="Add Client">
            </form>

            <a href="adminDashboard.jsp" class="back">Back to Dashboard</a>
        </div>

        <!-- Popup alert if message exists, then redirect -->
        <%
            String message = (String) request.getAttribute("message");
            if(message != null && !message.isEmpty()) {
        %>
        <script type="text/javascript">
            alert("<%= message %>");
            window.location.href = "adminDashboard.jsp"; // redirect to dashboard after alert
        </script>
        <%
            }
        %>
    </body>
</html>
