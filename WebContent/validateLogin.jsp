<%@ page language="java" import="java.io.*,java.sql.*"%>>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	String admin= "admin";

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null ){
		if (!authenticatedUser.equals(admin)){
			response.sendRedirect("index.jsp");		// Successful login
		}

		if( authenticatedUser.equals(admin)){
			response.sendRedirect("admin.jsp");		// admin login
		}
	}
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

		try 
		{
			getConnection();
			String sql = "SELECT * FROM Customer WHERE userId = ? and password = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);			
			pstmt.setString(1, username);
			pstmt.setString(2, password);
			
			ResultSet rst = pstmt.executeQuery();
					
			if (rst.next()){
				if(!password.equals("admin") & !username.equals("admin")){
					retStr = username; // Login successful	
					}
				else if ( password.equals("admin") & username.equals("admin")){
						retStr= "admin"; // if admin return admin
						}		
			}
		
		 
		 if(retStr != null)
		{	session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
		}
		
		else
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");

	}
		catch (SQLException ex) {
			out.println(ex);
		}	
		return retStr;
	
}

%>