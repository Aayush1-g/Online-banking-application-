<%@page import="com.onlinebanking.util.DBConnection"%>
<%@ page import="java.sql.*, java.text.DecimalFormat" %>
<%@ page session="true" %>
<%
    // Redirect to login if user not logged in
    if(session.getAttribute("user_id") == null){
        response.sendRedirect("login.jsp");
        return;
    }

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        con = DBConnection.getConnection(); // use your DBConnection class
        stmt = con.createStatement();

        // Fetch all bank accounts with user names
        String query = "SELECT b.account_id, u.name, b.account_number, b.ifsc, b.balance " +
                       "FROM bank_accounts b JOIN users u ON b.user_id = u.user_id";
        rs = stmt.executeQuery(query);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bank Accounts</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f7f8;
            padding: 20px;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 12px 15px;
            border: 1px solid #ddd;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
            text-transform: uppercase;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        a.logout {
            display: block;
            width: 100px;
            margin: 20px auto;
            padding: 10px;
            text-align: center;
            background: #e74c3c;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        a.logout:hover {
            background: #c0392b;
        }
    </style>
</head>
<body>
<h2>All Bank Accounts</h2>

<table>
    <tr>
        <th>Account ID</th>
        <th>User Name</th>
        <th>Account Number</th>
        <th>IFSC</th>
        <th>Balance (?)</th>
    </tr>

<%
        DecimalFormat df = new DecimalFormat("0.00"); // format balance
        while(rs.next()){
%>
    <tr>
        <td><%= rs.getInt("account_id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("account_number") %></td>
        <td><%= rs.getString("ifsc") %></td>
        <td><%= df.format(rs.getDouble("balance")) %></td>
    </tr>
<%
        } // end while
%>
</table>

<a href="logout.jsp" class="logout">Logout</a>

</body>
</html>

<%
    } catch(Exception e){
        out.println("<p style='color:red;text-align:center;'>Error: " + e.getMessage() + "</p>");
    } finally {
        try { if(rs != null) rs.close(); } catch(Exception e){}
        try { if(stmt != null) stmt.close(); } catch(Exception e){}
        try { if(con != null) con.close(); } catch(Exception e){}
    }
%>
