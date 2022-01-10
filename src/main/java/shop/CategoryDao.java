package shop;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class CategoryDao {
	
	private static CategoryDao instance;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs =null;
	int cnt=0;

	private CategoryDao() throws Exception{ 
		
		Context initContext = new InitialContext(); 
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
		conn = ds.getConnection();
	}
	
	public static CategoryDao getInstance() {
		if(instance == null) {
			try { 
				instance = new CategoryDao();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return instance;
	}//getInstance
	
	public int insertCategory(CategoryBean cb){
		int cnt=-1;
		String sql = "insert into category values(cate_seq.nextval,?,?)";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, cb.getCode());
			pstmt.setString(2, cb.getCname());
			
			cnt=pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt!=null) {
					pstmt.close();
				}
			}
			catch (Exception e) {
				
			}
		}
		return cnt;
	}//insertCategory
	
	public ArrayList<CategoryBean> getAllCategory(){
		ArrayList<CategoryBean> lists = new ArrayList<CategoryBean>();
		ResultSet rs = null ;
		String sql = "select * from category";
		try {
			pstmt=conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				CategoryBean record = new CategoryBean();
				record.setCnum(rs.getInt("cnum"));
				record.setCode(rs.getString("code")) ;
				record.setCname(rs.getString("cname")) ;
			
				lists.add(record);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();
				if(pstmt!=null)
					pstmt.close();
			}catch(SQLException e) {
				
			}
		}//finally
		return lists;
	}//getllCategroy
	
	public int deleteCategory(String cnum){
		int cnt = -1;
		String sql = "delete from category where cnum = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(cnum));
			cnt = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)
					pstmt.close();
			}catch(SQLException e) {
				
			}
		}//finally
		return cnt;
	}//deleteCategory
	
	
	
}
