package model;


public interface CustomerDAO {

	public abstract boolean update(byte[] password, String email,
			java.util.Date birth, String custid);
	public abstract CustomerBean select(String custid);

}