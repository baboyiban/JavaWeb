package com.ezen.servlet.lms;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LmsLoginDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public List<LmsUserVO> getList() {
		try {
			getConn();
			String sql = "SELECT * FROM lms_user UNION SELECT * FROM lms_user";
			this.pstmt = conn.prepareStatement(sql);
			this.rs = pstmt.executeQuery();
			List<LmsUserVO> list = new ArrayList<>();
			while(this.rs.next()) {
				String userid = this.rs.getString("userid");
				String pwd = this.rs.getString("pwd");
				String phone = this.rs.getString("phone");
				String email = this.rs.getString("phone");
				list.add(new LmsUserVO(userid,pwd,phone,email));
			}
			return list;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return null;
	}
	public List<LmsUserVO> getListUser() {
		try {
			getConn();
			String sql = "SELECT * FROM lms_user";
			this.pstmt = conn.prepareStatement(sql);
			this.rs = pstmt.executeQuery();
			List<LmsUserVO> list = new ArrayList<>();
			while(this.rs.next()) {
				String userid = this.rs.getString("userid");
				String pwd = this.rs.getString("pwd");
				String phone = this.rs.getString("phone");
				String email = this.rs.getString("phone");
				list.add(new LmsUserVO(userid,pwd,phone,email));
			}
			return list;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return null;
	}
	public List<LmsUserVO> getListAdmin() {
		try {
			getConn();
			String sql = "SELECT * FROM lms_admin";
			this.pstmt = conn.prepareStatement(sql);
			this.rs = pstmt.executeQuery();
			List<LmsUserVO> list = new ArrayList<>();
			while(this.rs.next()) {
				String userid = this.rs.getString("userid");
				String pwd = this.rs.getString("pwd");
				String phone = this.rs.getString("phone");
				String email = this.rs.getString("phone");
				list.add(new LmsUserVO(userid,pwd,phone,email));
			}
			return list;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return null;
	}
	public boolean addUser(LmsUserVO user) {
		try {
			getConn();
			String sql = "INSERT INTO lms_user (userid,pwd,phone,email) VALUES (?,?,?,?)";
			this.pstmt = conn.prepareStatement(sql);
			this.pstmt.setString(1, user.getUserid());
			this.pstmt.setString(2, user.getPwd());
			this.pstmt.setString(3, user.getPhone());
			this.pstmt.setString(4, user.getEmail());
			return this.pstmt.executeUpdate()>0?true:false;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return false;
	}
	public int test() {
		try {
			getConn();
			String sql = "SELECT count(*)result FROM lms_user WHERE userid=? AND pwd=?";
			this.pstmt = conn.prepareStatement(sql);
			this.pstmt.setString(1, "smith");
			this.pstmt.setString(2, "1111");
			this.rs = this.pstmt.executeQuery();
			this.rs.next();
			return this.rs.getInt("result");
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return 0;
	}

	
	private Connection getConn() {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","SCOTT","TIGER");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	private void closeAll() {
		try {
			if (conn != null) conn.close();
			if (pstmt != null) pstmt.close();
			if (rs != null) rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
