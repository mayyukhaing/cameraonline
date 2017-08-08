package ejb;

import java.util.List;
import javax.ejb.Remote;

@Remote

public interface ShoppingCart
{
	public void initialize(String person);
	public void addBook(String title);
	public void removeBook(String title);
	public List<String> getContents();
	public void remove();
}

