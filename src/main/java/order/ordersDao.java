package order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import shop.ProductBean;



public class ordersDao {

	private static ordersDao instance;
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs =null;
	int cnt=-1;

	public ordersDao() throws Exception{ //호출한곳으로 예외처리 넘김.
		
		Context initContext = new InitialContext(); //객체 생성 -> context.xml의 정보를 가져옴.
		//initContext = 가져온 정보가 저장됨.
		Context envContext = (Context)initContext.lookup("java:/comp/env");
		//눈에 보이지 않는 java:/comp/env 공간에 가져온 정보가 저장됨.
		DataSource ds = (DataSource)envContext.lookup("jdbc/OracleDB");
		conn = ds.getConnection();
		
	}
	
	public static ordersDao getInstance() {
		if(instance == null) {
			try { //생성자 호출한곳, 예외처리
				instance = new ordersDao();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return instance;
	}//getInstance
	
	public int insertOrder(ArrayList<ProductBean> calList,int memno) {
		
			for(int i=0;i<calList.size();i++) {
				String sql = "insert into orders(orderId,memno,pnum,qty,amount) "
						+ "values(orderseq.nextval,?,?,?,?)";
			
			try {
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, memno);
			pstmt.setInt(2,calList.get(i).getPnum());
			pstmt.setInt(3, calList.get(i).getPqty());
			pstmt.setInt(4, calList.get(i).getTotalPrice());
			cnt+=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
			}//for
			
		return cnt;
	}//insertOrder
	
	public int directinsertOrder(ProductBean bean,int memno) {
		
			String sql = "insert into orders(orderId,memno,pnum,qty,amount) "
					+ "values(orderseq.nextval,?,?,?,?)";
		
		try {
		
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, memno);
		pstmt.setInt(2,bean.getPnum());
		pstmt.setInt(3, bean.getPqty());
		pstmt.setInt(4, bean.getTotalPrice());
		cnt+=pstmt.executeUpdate();
		
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
		
	return cnt;
}//directinsertOrder
	
	public ArrayList<ordersBean> getOrderList(String memid){
		System.out.println("여기");
		ResultSet rs = null;
		ArrayList<ordersBean> olists = new ArrayList<ordersBean>();
		String sql = "select m.name mname, m.id mid, p.pname ppname, o.qty oqty, o.amount oamount "
				+ "from (members m join orders o on m.no = o.memno) join product p on o.pnum = p.pnum "
				+ "where m.id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,memid);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String mname = rs.getString("mname");
				String mid = rs.getString("mid");
				String ppname = rs.getString("ppname");
				int oqty = rs.getInt("oqty");
				int oamount = rs.getInt("oamount");
				ordersBean ob = new ordersBean(mname,mid,ppname,oqty,oamount);
				olists.add(ob);
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
		}
		return olists; // 
	}
}


