<%@ page session="true" %>
<%@ page import="java.sql.*, com.onlinebanking.util.DBConnection" %>
<%
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    String searchName = request.getParameter("searchName");
    String selectedIdParam = request.getParameter("user_id");
    int userId = 0;
    String name = "", email = "", city = "";
    double balance = 0;
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Update Client - Online Banking</title>
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
                width: 450px;
                text-align: center;
            }

            h2 {
                color: #1e3a8a;
                margin-bottom: 25px;
            }

            input[type=text], input[type=number] {
                width: 90%;
                padding: 10px;
                margin: 10px 0;
                border-radius: 6px;
                border: 1px solid #ccc;
            }

            input[type=submit] {
                padding: 10px 20px;
                margin-top: 10px;
                background: #457b9d;
                color: #fff;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: 0.3s ease;
            }

            input[type=submit]:hover {
                background: #1d3557;
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
        </style>

    </head>
    <body>
        <div class="container">
            <h2>Update Client Details</h2>

            <!-- Step 1: Search client by name -->
            <% if ((searchName == null || searchName.isEmpty()) && (selectedIdParam == null || selectedIdParam.isEmpty())) { %>
            <form method="get" action="updateClient.jsp">
                Enter Client Name: <input type="text" name="searchName" placeholder="Full or partial name" required><br>
                <input type="submit" value="Search Client">
            </form>
            <% } %>

            <!-- Step 2: Display search results if searchName exists -->
            <%
                if (searchName != null && !searchName.isEmpty() && (selectedIdParam == null || selectedIdParam.isEmpty())) {
                    try (Connection conn = DBConnection.getConnection()) {
                        PreparedStatement ps = conn.prepareStatement("SELECT * FROM clients WHERE name LIKE ?");
                        ps.setString(1, "%" + searchName + "%");
                        ResultSet rs = ps.executeQuery();

                        boolean hasResults = false;
            %>
            <table>
                <tr>
                    <th>User ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Balance</th>
                    <th>City</th>
                    <th>Select</th>
                </tr>
                <%
                    while (rs.next()) {
                        hasResults = true;
                %>
                <tr>
                    <td><%= rs.getInt("user_id")%></td>
                    <td><%= rs.getString("name")%></td>
                    <td><%= rs.getString("email")%></td>
                    <td><%= rs.getDouble("balance")%></td>
                    <td><%= rs.getString("city")%></td>
                    <td><a class="selectBtn" href="updateClient.jsp?user_id=<%= rs.getInt("user_id")%>">Edit</a></td>
                </tr>
                <%
                    }
                    if (!hasResults) {
                %>
                <tr><td colspan="6">No clients found with that name.</td></tr>
                <%
                    }
                %>
            </table>
            <%
                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    }
                }
            %>

            <!-- Step 3: Show update form if user_id is selected -->
            <%
                if (selectedIdParam != null && !selectedIdParam.isEmpty()) {
                    userId = Integer.parseInt(selectedIdParam);
                    try (Connection conn = DBConnection.getConnection()) {
                        PreparedStatement ps = conn.prepareStatement("SELECT * FROM clients WHERE user_id=?");
                        ps.setInt(1, userId);
                        ResultSet rs = ps.executeQuery();
                        if (rs.next()) {
                            name = rs.getString("name");
                            email = rs.getString("email");
                            balance = rs.getDouble("balance");
                            city = rs.getString("city");
            %>
            <form action="UpdateClientServlet" method="post" 
                  onsubmit="return confirm('Are you sure you want to update this client?');">
                <input type="hidden" name="user_id" value="<%= userId%>">
                Name: <input type="text" name="name" value="<%= name%>" required><br>
                Email: <input type="text" name="email" value="<%= email%>" required><br>
                Balance: <input type="number" step="0.01" name="balance" value="<%= balance%>" required><br>
                City: <input type="text" name="city" value="<%= city%>" required><br>
                <input type="submit" value="Update Client">
            </form>
            <%
                        } else {
                            out.println("<p>Client not found.</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    }
                }
            %>

            <a href="adminDashboard.jsp" class="back">Back to Dashboard</a>

            <!-- Success alert after update -->
            <%
                String message = (String) session.getAttribute("updateMessage");
                if (message != null) {
            %>
            <script type="text/javascript">
                alert("<%= message%>");
                window.location.href = "adminDashboard.jsp";
            </script>
            <%
                    session.removeAttribute("updateMessage");
                }
            %>

        </div>
    </body>
</html>
