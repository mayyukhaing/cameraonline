<%@ page import="java.util.*, javax.ejb.EJB, ejb.ShoppingCart, javax.naming.InitialContext" %>
<%!
	private static ShoppingCart cart;
	public void jspInit()
	{
		try
		{
			InitialContext ic = new InitialContext();
			cart = (ShoppingCart) ic.lookup(ShoppingCart.class.getName());
		}
		catch (Exception ex)
		{
			System.out.println("Couldn't create cart bean."+ ex.getMessage());
		}
	}
%>

<%
	if(request.getParameter("txtCustomerName") != null)
	{	
		cart.initialize(request.getParameter("txtCustomerName"));
	}
	else
	{
		cart.initialize("Guest");
	}

	if (request.getParameter("btnRmvLinux") != null)
	{
		String books[] = request.getParameterValues("chkLinux");
		if (books != null)
		{
			for (int i=0; i<books.length; i++)
			{
				cart.removeBook(books[i]);
			}
		}
	}

	if (request.getParameter("btnAddLinux") != null)
	{
		String books[] = request.getParameterValues("chkLinux");
		if (books != null)
		{
			for (int i=0; i<books.length; i++)
			{
				cart.addBook(books[i]); 
			}
		}
	}
%>
<HTML>
	<HEAD>
		<TITLE>Shopping Cart</TITLE>
	</HEAD>
	<BODY BGCOLOR='blue'>
		<H1 ALIGN='center'>Linux Books For Sale</H1><BR>
		<FORM NAME='frmLinuxBooks' METHOD='post'>
			<TABLE BGCOLOR='pink' WIDTH='100%' ALIGN='center' CELLPADDING='1' CELLSPACING='1'>
				<TR BGCOLOR='pink'>
					<TD WIDTH='70%'>
						<TABLE BGCOLOR='pink' WIDTH='400' ALIGN='center' CELLPADDING='1' CELLSPACING='1' BORDERCOLOR='maroon' BORDER='1'>
							<TR>
								<TD>Customer:</TD>
								<TD>
									<INPUT TYPE='text' NAME='txtCustomerName' VALUE=<%= request.getParameter("txtCustomerName")%> />
								</TD>
							</TR>
							<TR BGCOLOR='maroon'>
								<TH ALIGN='left' COLSPAN='2' WIDTH='340'>
									<B><FONT COLOR='WHITE'>Book Titles</FONT></B>
								</TH>
							</TR>
							<TR>
								<TD>
									<INPUT TYPE='checkbox' NAME='chkLinux'  VALUE='Using MySQL on Linux'>
								</TD>
								<TD WIDTH='340'>Using MySQL on Linux </TD>
							</TR>
							<TR>
								<TD>
									<INPUT TYPE='checkbox' NAME='chkLinux'  VALUE='Using OpenOffice on Linux'>
								</TD>
								<TD WIDTH='340'>Using OpenOffice on Linux </TD>
							</TR>
							<TR>
								<TD>
									<INPUT TYPE='checkbox' NAME='chkLinux'  VALUE='Using Staroffice 7.0 on Linux'>
								</TD>
								<TD WIDTH='340'>Using Staroffice 7.0 on Linux </TD>
							</TR>
							<TR>
								<TD>
									<INPUT TYPE='checkbox' NAME='chkLinux'  VALUE='Application Development With Oracle & PHP on Linux'>
								</TD>
								<TD WIDTH='340' HEIGHT='24'>App. Development With Oracle & PHP On Linux </TD>
							</TR>
							<TR>
								<TD COLSPAN='4'>
									<TABLE BGCOLOR='pink' ALIGN='center'>
										</TR>
											<TD COLSPAN='2' ALIGN='right'>
												<INPUT TYPE='submit' VALUE='Add To My Basket' NAME='btnAddLinux'>
											</TD>
											<TD COLSPAN='2' ALIGN='right'>
												<INPUT TYPE='submit' VALUE='Remove From My Basket' NAME='btnRmvLinux'>
											</TD>
										</TR>
									</TABLE>
								</TD>
							</TR>
						</TABLE>
					</TD>
					<TD>
						<TABLE BORDER='1' ALIGN='right' BORDERCOLOR='blue' WIDTH='300' HEIGHT='250'>
							<TR>
								<TD ALIGN='center' BGCOLOR='lightblue' COLSPAN='2' HEIGHT='20'>Basket</TD>
							</TR>
							<TR>
								<TD ALIGN='center' BGCOLOR='lightblue' HEIGHT='20'>Book</TD>
							</TR>
							<%
								List<String> bookList = cart.getContents();
								Iterator iterator = bookList.iterator();
								while (iterator.hasNext())
								{
									String title = (String) iterator.next();
							%>
									<TR>
										<TD ALIGN='left' BGCOLOR='lightblue'><%= title %></TD>
									</TR>
							<%
								}
							%>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</FORM>
	</BODY>
</HTML>