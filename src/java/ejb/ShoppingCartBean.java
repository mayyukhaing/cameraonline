package ejb;

import java.util.ArrayList;
import java.util.List;
import javax.ejb.Remove;
import javax.ejb.Stateful;
import java.sql.*;
import java.io.*;

@Stateful()

public class ShoppingCartBean implements ShoppingCart
{
	List<String> contents;
	String customerName;

	private Connection conn = null;
	private ResultSet rs;
	private Statement stmt = null;
	private String query = null;

	public void initialize(String person)
	{
		if (person != null)
		{
			customerName = person;
			try
			{
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				conn = DriverManager.getConnection("jdbc:mysql://localhost/test", "root", "");
			}
			catch(Exception e)
			{
				System.err.println("Failed to connect to the Database." + e.getMessage());
			}
		}
		contents = new ArrayList<String>();
	}

	public void addBook(String title)
	{
		try
		{
			stmt = conn.createStatement();
			query = "INSERT INTO Cart VALUES('" + customerName + "','" + title + "')";
			stmt.executeUpdate(query);
		}
		catch(Exception e)
		{
			System.err.println("Failed to insert values. " + e.getMessage());
		}
	}

	public void removeBook(String title)
	{
		try
		{
			stmt = conn.createStatement();
			query = "DELETE FROM Cart WHERE UserName='" + customerName + "' AND ItemName='" + title + "'";
			stmt.executeUpdate(query);
		}
		catch(Exception e)
		{
			System.err.println("Failed to delete values. " + e.getMessage());
		}
	}

	public List<String> getContents()
	{
		try
		{
			stmt = conn.createStatement();
			query = "SELECT * FROM Cart WHERE UserName='" + customerName + "'";
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
				contents.add(rs.getString("ItemName"));
			}
		}
		catch(Exception e)
		{
			System.err.println("Failed to select values. " + e.getMessage());
		}
		return contents;
	}

	@Remove()

	public void remove()
	{
		contents = null;
	}
}