package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;


public class BoardDao {

	//BoardDao 객체 싱글톤 패턴으로 만들기
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String id="jspid";
	String pw="jsppw";
	private static BoardDao instance;
	Connection conn = null;
	PreparedStatement ps=null;
	ResultSet rs = null;
	ArrayList<BoardBean> lists = new ArrayList<BoardBean>();
	
	private BoardDao() {

		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,id,pw);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static BoardDao getInstance() {
		if(instance == null) {
			instance = new BoardDao();
		}
		return instance;
	}
	
	public int getArticleCount() {
		int count=0;
		String sql = "select count(*) as count from board";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			
				try {
					if(rs!=null)
						rs.close();
					if(ps!=null)
						ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}//finally
		return count;
	}//getArticleCount
	
	public ArrayList<BoardBean> getArticles(int start, int end){
		ArrayList<BoardBean> lists = new ArrayList<BoardBean>();
		String sql = "select num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level,content,ip ";
		sql += "from (select rownum as rank, num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level,content,ip ";
		sql += "from (select num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level,content,ip " ;
		sql += "from board ";
		sql += "order by ref desc, re_step asc)) ";
		sql += "where rank between ? and ? ";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1,start);
			ps.setInt(2,end);
			rs = ps.executeQuery();
			while(rs.next()) {
				int num=rs.getInt("num");
				String writer=rs.getString("writer");
				String email=rs.getString("email");
				String subject=rs.getString("subject");
				String passwd=rs.getString("passwd");
				Timestamp reg_date=rs.getTimestamp("reg_date");
				int readcount=rs.getInt("readcount");
				int ref=rs.getInt("ref");
				int re_step=rs.getInt("re_step");
				int re_level=rs.getInt("re_level");
				String content=rs.getString("content");
				String ip=rs.getString("ip");
				
				BoardBean bean=new BoardBean(num, writer, email, subject, passwd, reg_date, readcount, ref, re_step, re_level, content, ip);
				lists.add(bean);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(ps!=null)
					ps.close();
			}catch(SQLException e) {
				
			}
		}
		
		return lists;
	}//
	
	public int insertArticle(BoardBean bb) { // 원글
		int cnt=0;
		String sql = "insert into board(num,writer,email,subject,passwd,reg_date,readcount,ref,re_step,re_level,content,ip) " + 
					"values(board_seq.nextval,?,?,?,?,?,0,board_seq.currval,?,?,?,?)";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1,bb.getWriter());
			ps.setString(2,bb.getEmail());
			ps.setString(3,bb.getSubject());
			ps.setString(4,bb.getPasswd());
			ps.setTimestamp(5,bb.getReg_date());
			ps.setInt(6,0); // re_step
			ps.setInt(7,0); // re_level
			ps.setString(8, bb.getContent());
			ps.setString(9, bb.getIp());
			
			cnt = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return cnt;
	}//insertArticle
	
	public BoardBean getArticle(int num){ //조회수를 먼저 1증가 update 후 전체 select
		String sqlUpdate = "update board set readcount=readcount+1 where num=?";
		//조회수 업데이트 sql
		String sql = "select * from board where num = ?" ;
		BoardBean article=null;
		try {
			ps = conn.prepareStatement( sqlUpdate ) ;
			ps.setInt(1, num);	
			ps.executeUpdate(); //조회수 업데이트 sql 실행
			
			ps = conn.prepareStatement( sql ) ;
			ps.setInt(1, num);	
			rs = ps.executeQuery();
			if (rs.next()) {
				article = new BoardBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));  
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(ps!=null) 
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return article;
	}//getArticle
	
	public BoardBean updateFormArticle(int num){
		String sql = "select * from board where num = ?" ;
		BoardBean article=null;
		try {
			ps = conn.prepareStatement( sql ) ;
			ps.setInt(1, num);	
			rs = ps.executeQuery();
			if (rs.next()) {
				article = new BoardBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));  
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(ps!=null) 
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return article;
	}//updateFormArticle
		
	public int updateArticle(BoardBean article){// updateForm 에서 입력한 5가지 + 날짜 1가지 6개가 묶여서 넘어온다.
		String sqlSelect = "select passwd from board where num =?";
		String sqlUpdate = "update board set writer=?,subject=?,email=?,content=?,reg_date=? where num=?"; 
		//입력한 5가지 중 비번 제외 4가지+날짜 // num
		String dbpasswd = null;
		int cnt=-1;
		try {
			ps = conn.prepareStatement(sqlSelect);
			ps.setInt(1, article.getNum());
			rs = ps.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(article.getPasswd())){ //db에 저장된 pw 와 수정폼 입력 pw 일치확인
					ps = conn.prepareStatement(sqlUpdate);
					ps.setString(1, article.getWriter());
					ps.setString(2, article.getSubject());
					ps.setString(3, article.getEmail());
					ps.setString(4, article.getContent());
					ps.setTimestamp(5, article.getReg_date());
					ps.setInt(6, article.getNum());
					
					cnt=ps.executeUpdate();
				}
				else {//비번 불일치
					cnt=0;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)
					rs.close();
				if(ps!=null) 
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return cnt; //실패 cnt -1 / 비번일치 양수 / 비번불일치 0
		
	}
	
	public int deleteArticle(String passwd,int num) {
		String sqlSelect="select passwd from board where num =?";
		String sqlDelete="delete from board where num=?";
		String dbpasswd = null;
		int cnt=0;
		try {
			ps = conn.prepareStatement(sqlSelect);
			ps.setInt(1, num);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				dbpasswd = rs.getString("passwd");
				if(dbpasswd.equals(passwd)){ //db에 저장된 pw 와 수정폼 입력 pw 일치확인
					ps = conn.prepareStatement(sqlDelete);
					ps.setInt(1, num);
					cnt=ps.executeUpdate();
				}
				else {//비번 불일치
					cnt=-1;
				}
			}//if
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(rs!=null)
					rs.close();
				if(ps!=null) 
					ps.close();
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return 0;
	}//deleteArticle
	
	public void replyArticle(BoardBean article){
		//ref,re_step,re_level:부모
		// 나머지:내것
		String sqlUpdate = "update board set re_step = re_step+1 where ref=? and re_step > ?";
		String sqlInsert = "insert into board(num,writer,email,subject,passwd, reg_date,ref,re_step,re_level,content,ip) " +
		"values(board_seq.nextval,?,?,?,?,?,?,?,?,?,?)";
		
		try {
			ps = conn.prepareStatement(sqlUpdate);
			ps.setInt(1, article.getRef());
			ps.setInt(2, article.getRe_step());
			ps.executeUpdate();
			
			ps = conn.prepareStatement(sqlInsert);
			ps.setString(1, article.getWriter());
			ps.setString(2, article.getEmail());
			ps.setString(3, article.getSubject());
			ps.setString(4, article.getPasswd());
			ps.setTimestamp(5, article.getReg_date());
			ps.setInt(6, article.getRef());
			ps.setInt(7, article.getRe_step()+1);
			ps.setInt(8, article.getRe_level()+1);
			ps.setString(9, article.getContent());
			ps.setString(10, article.getIp());
			ps.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(ps!=null)
					ps.close();
				
			}catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
