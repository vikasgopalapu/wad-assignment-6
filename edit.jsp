<%@ page import="java.sql.*" %>
<%@ page import="DBConnection" %>

<%
int id = Integer.parseInt(request.getParameter("id"));

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM students WHERE id=?"
);
ps.setInt(1, id);

ResultSet rs = ps.executeQuery();
rs.next();
%>

<html>
<body>

<h2>Edit Student</h2>

<form action="update" method="post">
<input type="hidden" name="id" value="<%= id %>">

Name: <input type="text" name="name" value="<%= rs.getString("name") %>"><br><br>
Email: <input type="text" name="email" value="<%= rs.getString("email") %>"><br><br>
Course: <input type="text" name="course" value="<%= rs.getString("course") %>"><br><br>

<input type="submit" value="Update">
</form>

</body>
</html>
