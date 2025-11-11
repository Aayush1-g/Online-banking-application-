<%@ page session="true" %>
<%@ page import="java.sql.*, com.onlinebanking.util.DBConnection" %>
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
    <title>View Clients - Online Banking</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #cce7ff, #99d1ff);
            margin: 0;
            padding: 50px 20px;
            display: flex;
            justify-content: center;
        }

        .container {
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.08);
            width: 500px;
            text-align: center;
        }

        h2 {
            color: #1e3a8a;
            margin-bottom: 25px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: #ffffff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 6px 12px rgba(0,0,0,0.05);
        }

        th, td {
            padding: 12px 10px;
            text-align: center;
        }

        th {
            background: #457b9d;
            color: #fff;
            font-weight: 600;
        }

        tr:nth-child(even) td {
            background: #f0f8ff;
        }

        a.selectBtn {
            padding: 6px 12px;
            background: #a8dadc;
            color: #1d3557;
            text-decoration: none;
            border-radius: 5px;
            transition: 0.3s ease;
        }

        a.selectBtn:hover {
            background: #457b9d;
            color: white;
        }

        .back {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 18px;
            background: #a8dadc;
            color: #1d3557;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 500;
            transition: 0.3s ease;
        }

        .back:hover {
            background: #457b9d;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>All Clients and their Details:</h2>

        <table>
            <tr>
                <th>User ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Balance</th>
                <th>City</th>
            </tr>
            <%
                try (Connection conn = DBConnection.getConnection()) {
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM clients ORDER BY user_id");

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("user_id")%></td>
                <td><%= rs.getString("name")%></td>
                <td><%= rs.getString("email")%></td>
                <td>Rs <%= rs.getDouble("balance")%></td>
                <td><%= rs.getString("city")%></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("<tr><td colspan='5'>Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </table>

        <a href="adminDashboard.jsp" class="back">Back to Dashboard</a>
    </div>
</body>
</html>
