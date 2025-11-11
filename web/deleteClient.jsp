<%@ page session="true" %>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="com.onlinebanking.util.DBConnection" %>
<%
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    // Fetch clients
    List<Map<String, Object>> clients = new ArrayList<>();
    try (Connection conn = DBConnection.getConnection()) {
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM clients");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Map<String, Object> c = new HashMap<>();
            c.put("user_id", rs.getInt("user_id"));
            c.put("name", rs.getString("name"));
            c.put("email", rs.getString("email"));
            c.put("balance", rs.getDouble("balance"));
            c.put("city", rs.getString("city"));
            clients.add(c);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Delete Client - Online Banking</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #cce7ff, #99d1ff);
                margin: 0;
                padding: 40px;
            }

            h2 {
                text-align: center;
                color: #1e3a8a;
                margin-bottom: 25px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background: #ffffff;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 10px 20px rgba(0,0,0,0.08);
            }

            th, td {
                padding: 12px 15px;
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

            input[type=submit] {
                padding: 6px 12px;
                background: #e63946;
                color: #fff;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: 0.3s ease;
            }

            input[type=submit]:hover {
                background: #d62828;
            }

            .back {
                margin-top: 20px;
                display: inline-block;
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

        <h2>Delete Client</h2>

        <table>
            <tr>
                <th>User ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Balance</th>
                <th>City</th>
                <th>Action</th>
            </tr>
            <%
                for (Map<String, Object> c : clients) {
            %>
            <tr>
                <td><%= c.get("user_id")%></td>
                <td><%= c.get("name")%></td>
                <td><%= c.get("email")%></td>
                <td><%= c.get("balance")%></td>
                <td><%= c.get("city")%></td>
                <td>
                    <form action="DeleteClientServlet" method="post" 
                          onsubmit="return confirm('Are you sure you want to delete this client?');">
                        <input type="hidden" name="user_id" value="<%= c.get("user_id")%>">
                        <input type="submit" value="Delete">
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </table>

        <div style="text-align: center; margin-top: 20px;">
    <a href="adminDashboard.jsp" class="back">Back to Dashboard</a>
</div>


        <%
            // Alert after deletion + redirect to dashboard
            String deleteMsg = (String) session.getAttribute("deleteMessage");
            if (deleteMsg != null) {
        %>
        <script type="text/javascript">
    alert("<%= deleteMsg%>");
    window.location.href = "adminDashboard.jsp";
        </script>
        <%
                session.removeAttribute("deleteMessage");
            }
        %>

    </body>
</html>
