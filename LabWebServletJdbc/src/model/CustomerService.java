package model;

import java.util.Arrays;

import model.dao.CustomerDAOJdbc;

public class CustomerService {
	private CustomerDAO customerDao = new CustomerDAOJdbc();
	public static void main(String[] args) {
		CustomerService service = new CustomerService();
		
		CustomerBean bean = service.login("Alex", "A");
		System.out.println(bean);

		boolean result = service.changePassword("Ellen", "EEE", "E");
		System.out.println("result="+result);
	}
	public boolean changePassword(String username, String oldPassword, String newPassword) {
		if(newPassword!=null && newPassword.length()!=0) {
			CustomerBean bean = this.login(username, oldPassword);
			if(bean!=null) {
				byte[] temp = newPassword.getBytes();
				return customerDao.update(temp, bean.getEmail(), bean.getBirth(), username);
			}
		}
		return false;
	}
	public CustomerBean login(String username, String password) {
		if(password!=null && password.length()!=0) {
			CustomerBean bean = customerDao.select(username);
			if(bean!=null) {	
				byte[] temp = password.getBytes();	//使用者輸入byte[]
				byte[] pass = bean.getPassword();	//資料庫抓出byte[]
				if(Arrays.equals(temp, pass)) {
					return bean;
				}
			}	
		}
		return null;
	}
}
