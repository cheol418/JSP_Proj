package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;

public class ProductDao {

	private static ProductDao instance;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs =null;
	ProductBean bean=null;
	int cnt=-1;
	ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
	
	private ProductDao() throws Exception{ 
		//DBCP
		Context initContext = new InitialContext(); 
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
		conn = ds.getConnection();
		
	}
	
	public static ProductDao getInstance() {
		if(instance == null) {
			try { 
				instance = new ProductDao();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return instance;
	}//getInstance
	
	
	public int insertProduct(MultipartRequest mr){
		int cnt=-1;

		String sql="insert into product values(catprod.nextval,?,?,?,?,?,?,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mr.getParameter("pname"));
			
			String pcategory_fk =  mr.getParameter("pcategory_fk");
			pcategory_fk += mr.getParameter("pcode"); 
			
			pstmt.setString(2, pcategory_fk); 
			pstmt.setString(3, mr.getParameter("pcompany"));
			pstmt.setString(4,mr.getFilesystemName("pimage")); 
			pstmt.setInt(5, Integer.parseInt(mr.getParameter("pqty")));
			pstmt.setInt(6, Integer.parseInt(mr.getParameter("price")));
			pstmt.setString(7, mr.getParameter("pspec"));
			pstmt.setString(8, mr.getParameter("pcontents"));
			pstmt.setInt(9, Integer.parseInt(mr.getParameter("point")));
			
			Date d = new Date(); 
			System.out.println(d); 
			SimpleDateFormat  sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(d);
			pstmt.setString(10,today);
			
			cnt = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}  finally {
			try {
				if(pstmt!=null)
					pstmt.close();
			}catch(SQLException e) {

			}
		}	

		return cnt;
	}//insertProduct
	
	public ArrayList<ProductBean> getAllProduct(){
		ResultSet rs = null;  
		String sql = "select * from product order by pnum";
		ProductBean bean = null;
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();

		try { 
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while(rs.next()) {
				int pnum = rs.getInt("pnum");
				String pname = rs.getString("pname");
				String pcategory_fk = rs.getString("pcategory_fk");
				String pcompany = rs.getString("pcompany");
				String pimage = rs.getString("pimage");
				int pqty =rs.getInt("pqty");
				int price = rs.getInt("price");
				String pspec = rs.getString("pspec");
				String pcontents = rs.getString("pcontents");
				int point = Integer.parseInt(rs.getString("point"));
				String pinputdate = rs.getString("pinputdate");
				bean = new ProductBean(pnum,pname,pcategory_fk,pcompany,pimage,pqty,price,pspec,pcontents,point,pinputdate);
				lists.add(bean); 
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return lists;
	}//
	
	public ProductBean selectByPnum(int pnum) {
		String sql="select * from product where pnum=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int pnum2 = rs.getInt("pnum");
				String pname = rs.getString("pname");
				String pcategory_fk = rs.getString("pcategory_fk");
				String pcompany = rs.getString("pcompany");
				String pimage = rs.getString("pimage");
				int pqty =rs.getInt("pqty");
				int price = rs.getInt("price");
				String pspec = rs.getString("pspec");
				String pcontents = rs.getString("pcontents");
				int point = Integer.parseInt(rs.getString("point"));
				String pinputdate = rs.getString("pinputdate");
				
				bean = new ProductBean(pnum2,pname,pcategory_fk,pcompany,pimage,pqty,price,pspec,pcontents,point,pinputdate);
				lists.add(bean); 
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null) {
					rs.close();
				}
				if(pstmt!=null) {
					pstmt.close();
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return bean;
	}//selectByPnum
	
	public int updateProduct(MultipartRequest mr) {
		int cnt = -1;
		String sql = "update product set pname=?,pcompany=?,pimage=?,pqty=?,price=?,pspec=?,pcontents=?,point=? where pnum=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mr.getParameter("pname"));
			pstmt.setString(2, mr.getParameter("pcompany"));
			
			String pimage = mr.getFilesystemName("pimage"); // 새이미지
			String pimage2 = mr.getParameter("pimage2") ; // 기존이미지
			
			if(pimage == null) { // 
				if(pimage2!=null) { // 
					pimage = pimage2 ;
				}
				else { // 
					pimage = null;
				}
			}
			pstmt.setString(3, pimage);
			//pstmt.setString(3, mr.getFilesystemName("pimage"));
			
			pstmt.setInt(4, Integer.parseInt(mr.getParameter("pqty")));
			pstmt.setString(5, mr.getParameter("price"));
			pstmt.setString(6, mr.getParameter("pspec"));
			pstmt.setString(7, mr.getParameter("pcontents"));
			pstmt.setString(8, mr.getParameter("point"));
			pstmt.setString(9, mr.getParameter("pnum"));
			
			cnt = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} // finally
		return cnt;
		
	}//updateProduct

	
	public ArrayList<ProductBean> selectByPspec(String pspec) {
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		String sql = "select * from product where pspec=?";
		ProductBean bean = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pspec);;
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int pnum = rs.getInt("pnum");
				String pname = rs.getString("pname");
				String pcategory_fk = rs.getString("pcategory_fk");
				String pcompany = rs.getString("pcompany");
				String pimage = rs.getString("pimage");
				int pqty = rs.getInt("pqty");
				int price = rs.getInt("price");
				String pspec2 = rs.getString("pspec");
				String pcontents = rs.getString("pcontents");
				int point = rs.getInt("point");
				String pinputdate = rs.getString("pinputdate");
				
				bean = new ProductBean(pnum,pname,pcategory_fk,pcompany,pimage,pqty,price,pspec2,pcontents,point,pinputdate);
				lists.add(bean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();
				if(pstmt!=null)
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return lists;
	}//selectByPspec
	
	public ArrayList<ProductBean> getselectByCategory(String code) {
		ArrayList<ProductBean> lists = new ArrayList<ProductBean>();
		String sql = "select * from product where pcategory_FK like ?";
		ProductBean bean = null;
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, code+"%");;
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int pnum = rs.getInt("pnum");
				String pname = rs.getString("pname");
				String pcategory_fk = rs.getString("pcategory_fk");
				String pcompany = rs.getString("pcompany");
				String pimage = rs.getString("pimage");
				int pqty = rs.getInt("pqty");
				int price = rs.getInt("price");
				String pspec = rs.getString("pspec");
				String pcontents = rs.getString("pcontents");
				int point = rs.getInt("point");
				String pinputdate = rs.getString("pinputdate");
				
				bean = new ProductBean(pnum,pname,pcategory_fk,pcompany,pimage,pqty,price,pspec,pcontents,point,pinputdate);
				lists.add(bean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();
				if(pstmt!=null)
					pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return lists;
	}//getselectByCategory
	
}
