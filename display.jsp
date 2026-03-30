<%@ page import="java.sql.*" %>
<%@ page import="DBConnection" %>

<html>
<head>
<title>Student Records</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

<h2>Student Records</h2>

<!-- 🔍 SEARCH BOX -->
<form method="get">
    Search by Name: 
    <input type="text" name="search">
    <input type="submit" value="Search">
</form>

<br>

<table>
<tr>
<th>S.No</th>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Course</th>
<th>Action</th>
</tr>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

int count = 1;

try {
    con = DBConnection.getConnection();

    String search = request.getParameter("search");

    if(search != null && !search.trim().equals("")) {
        ps = con.prepareStatement(
            "SELECT * FROM students WHERE name LIKE ?"
        );
        ps.setString(1, "%" + search + "%");
    } else {
        ps = con.prepareStatement("SELECT * FROM students");
    }

    rs = ps.executeQuery();

    while(rs.next()){
%>

<tr>
<td><%= count++ %></td>
<td><%= rs.getInt("id") %></td>
<td><%= rs.getString("name") %></td>
<td><%= rs.getString("email") %></td>
<td><%= rs.getString("course") %></td>

<td>
<a href="edit.jsp?id=<%= rs.getInt("id") %>">Edit</a> |
<a href="delete?id=<%= rs.getInt("id") %>" 
   onclick="return confirm('Are you sure to delete?')">Delete</a>
</td>
</tr>

<%
    }

} catch(Exception e) {
    out.println("Error: " + e.getMessage());
} finally {
    if(rs != null) rs.close();
    if(ps != null) ps.close();
    if(con != null) con.close();
}
%>

</table>

<br>

<a href="index.html">➕ Add New Student</a>

</body>
</html>
