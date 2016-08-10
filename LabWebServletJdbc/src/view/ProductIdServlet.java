package view;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import model.ProductBean;
import model.ProductService;
@WebServlet(
		urlPatterns={"/pages/product.view"}
)
public class ProductIdServlet extends HttpServlet {
	private ProductService service = new ProductService();
	private void json(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter out = response.getWriter();
		StringBuilder output = new StringBuilder();
		
//接收資料、驗證資料、轉換資料
		String temp = request.getParameter("id");
		int id = 0;
		if(temp==null || temp.trim().length()==0) {
			output.append("ID是必要欄位");
		} else {
			id = ProductBean.convertInt(temp);
			if(id==-1000) {
				output.append("ID必需是數字");
			}
		}
		if(output!=null && output.length()!=0) {
			JSONArray jsonArray = new JSONArray();
			JSONObject obj = new JSONObject();
			obj.put("text", output.toString());
			obj.put("hasMoreData", false);
			jsonArray.put(obj);
			
			out.write(jsonArray.toString());
			out.close();
			return;
		}
		
//呼叫Model
		ProductBean bean = new ProductBean();
		bean.setId(id);
		List<ProductBean> result = service.select(bean);
		
		JSONArray jsonArray = new JSONArray();
		if(result==null || result.isEmpty()) {
			JSONObject obj = new JSONObject();
			obj.put("text", "ID不存在");
			obj.put("hasMoreData", false);
			jsonArray.put(obj);
		} else {
			JSONObject obj1 = new JSONObject();
			obj1.put("text", "ID存在");
			obj1.put("hasMoreData", true);
			jsonArray.put(obj1);

			ProductBean data = result.get(0);
			JSONObject obj2 = new JSONObject();
			obj2.put("id", data.getId());
			obj2.put("name", data.getName());
			obj2.put("price", data.getPrice());
			obj2.put("make", data.getMake().toString());
			obj2.put("expire", data.getExpire());

			jsonArray.put(obj2);
		}

		out.write(jsonArray.toString());
		out.close();
		return;
	}
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("method="+request.getMethod());
		this.json(request, response);
	}

}
