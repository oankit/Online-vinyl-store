<%
	// Remove the user from the session to log them out
	session.setAttribute("productList",null);
	response.sendRedirect("showcart.jsp");		// Re-direct to main page
%>