package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class memberDao {
	
	private static memberDao instance;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs =null;
	memberBean bean=null;
	int cnt=-1;
	
	private memberDao() throws Exception{
		Context initContext = new InitialContext(); 
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
		conn = ds.getConnection();
	}//생성자
	
	public static memberDao getInstance() {
		if(instance == null) {
			try {
				instance = new memberDao();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return instance;
	}//getInstance
	
	public memberBean getMemberBean(ResultSet rs) {
		try {
			int no = rs.getInt("no");
			String id2 = rs.getString("id");
			String pw2 = rs.getString("pw");
			String name = rs.getString("name");
			String b_date = rs.getString("b_date");
			String gender = rs.getString("gender");
			String email = rs.getString("email");
			String phone = rs.getString("phone");
			
			bean = new memberBean(no, id2,pw2,name,b_date,gender,email,phone);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return bean;
	}
	
	public boolean searchId(String userid) {
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		memberBean bean = null;
		boolean flag = false;
		String sql = "select * from member where id=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag= true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null)
					rs.close();
				if(pstmt!=null)
					pstmt.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
		} //finally
		
		return flag;
		
	}//searchId
	
	public int insertMember(memberBean bean){
		String sql = "insert into member values(mem_seq.nextval,?,?,?,?,?,?,?)";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPw());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getB_date());
			pstmt.setString(5, bean.getGender());
			pstmt.setString(6, bean.getEmail());
			pstmt.setString(7, bean.getPhone());
			cnt=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return cnt;
	}//insertMember
	
	public memberBean getMemberInfo(String id,String pw) { //loginProc -> dao
		String sql = "select * from member where id=? and pw=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				int no = rs.getInt("no");
				String id2 = rs.getString("id");
				String pw2 = rs.getString("pw");
				String name = rs.getString("name");
				String b_date = rs.getString("b_date");
				String gender = rs.getString("gender");
				String email = rs.getString("email");
				String phone = rs.getString("phone");
				
				bean = new memberBean(no, id2,pw2,name,b_date,gender,email,phone);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(pstmt!=null)
					pstmt.close();
			}catch(SQLException e) {

			}
		}
		
		return bean;
	}//getMemberInfo
}
