package com.ezen.servlet.lms;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LmsDAO {
	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public List<Lms_statusVO> getStatusList1() 
	{
		getConn();
		String sql="SELECT userid, lvl_code, lms_num,lms_tnum, test_date,t_feedback,pass \r\n"
				+ "FROM lms_status\r\n"
				+ "group by userid, lvl_code, lms_num,lms_tnum, test_date,t_feedback,pass\r\n"
				+ "order by test_date";
		try {
			this.stmt=conn.createStatement();
			this.rs=stmt.executeQuery(sql);
			List<Lms_statusVO> list = new ArrayList<>();
			while(rs.next())
			{
				String userid =rs.getString("userid");
				int lvl_code = rs.getInt("lvl_code");
				String lms_num = rs.getString("lms_num");
				java.sql.Timestamp  test_date = rs.getTimestamp("test_date");	
				//System.out.println(test_date);
				int lms_tnum = rs.getInt("lms_tnum");
				String t_feedback = rs.getString("t_feedback");
				boolean pass = Integer.valueOf(rs.getString("pass").strip())==1?true:false;
				//System.out.println("pass: "+Integer.valueOf(rs.getString("pass").strip()));
				//System.out.println("pass 값:"+pass);
				//System.out.println("여기"+"lvl_code: "+lvl_code+test_date);
				Lms_statusVO lms = new Lms_statusVO();
				lms.setUserid(userid);
				lms.setLms_num(lms_num);
				lms.setLvl_code(lvl_code);
				lms.setLms_tnum(lms_tnum);
				lms.setTest_date(test_date);
				lms.setLms_tnum(lms_tnum);
				lms.setT_feedback(t_feedback);
				lms.setPass(pass);

				list.add(lms);				
			}
			//System.out.println("지금여기");
			return list;		

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeAll();
		}

		return null;
	}
	public List<Lms_statusVO> getStatus(String userid) {
		try {
			getConn();
			String sql = "SELECT * FROM lms_status WHERE userid=?";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1,userid);
			this.rs = this.pstmt.executeQuery();
			
			List<Lms_statusVO> listStatus = new ArrayList<>();
			while (this.rs.next() && this.rs.getString("userid")!=null) {
				Lms_statusVO status = new Lms_statusVO();
				status.setUserid(this.rs.getString("userid")); // 유저 아이디
				status.setLvl_code(this.rs.getInt("lvl_code")); // 과목
				status.setLms_num(this.rs.getString("lms_num")); // 강의 번호 1.1
				status.setTest_date(this.rs.getTimestamp("test_date")); // 테스트 본 날짜
				status.setLms_tnum(this.rs.getInt("lms_tnum"));
				status.setLms_qid(this.rs.getInt("lms_qid"));
				status.setLms_question(this.rs.getString("lms_question"));
				status.setLms_aid(this.rs.getInt("lms_aid"));
				status.setLms_anum(this.rs.getString("lms_anum"));
				status.setT_feedback(this.rs.getString("t_feedback")); // 피드백
				status.setLms_scoring(this.rs.getInt("lms_scoring"));
				status.setPass(this.rs.getInt("pass")==1);
				listStatus.add(status);
			}
			return listStatus;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return null;
	}
	public void setStatus(Lms_statusVO status) {
		try {
			getConn();
			String sql = "INSERT INTO lms_status (?,?,?,test_date,?,?,?,?,?,?,?,pass) VALUES ('smith',1,'1.1',CURRENT_TIMESTAMP,1,1,'질문',1,'1.1','참잘했어요',80,1)";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, status.getUserid());
			this.pstmt.setInt(2, status.getLvl_code());
			this.pstmt.setString(3, status.getLms_num());
			this.pstmt.setInt(4, status.getLms_tnum());
			this.pstmt.setInt(5, status.getLms_qid());
			this.pstmt.setString(6, status.getLms_question());
			this.pstmt.setInt(7, status.getLms_aid());
			this.pstmt.setString(8, status.getLms_anum());
			this.pstmt.setString(9, status.getT_feedback());
			this.pstmt.setInt(10, status.getLms_scoring());
			this.pstmt.setString(11, status.isPass()==true?"1":"0");
			this.pstmt.execute();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
	}
	public List<Lms_subjectVO> getListSubject() {
		try {
			List<Lms_subjectVO> listSubject = new ArrayList<>();
			getConn();
			String sql = "SELECT * FROM lms_subject ORDER BY lvl_code";
			this.pstmt = this.conn.prepareStatement(sql);
			this.rs = this.pstmt.executeQuery();
			while (this.rs.next() && this.rs.getInt("lvl_code")!=0) {
				Lms_subjectVO subject = new Lms_subjectVO();
				subject.setLvl_code(this.rs.getInt("lvl_code"));
				subject.setSubject_name(this.rs.getString("subject_name"));
				subject.setSubject_description(this.rs.getString("subject_description"));
				listSubject.add(subject);
			}
			return listSubject;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return null;
	}
	public Map<Integer,List<Lms_lectureVO>> getMapListLecture() {
		try {
			getConn();
			Map<Integer,List<Lms_lectureVO>> mapListLecture = new HashMap<>();
			for (int i = 0; i < 3; i++) {
				String sql = "SELECT * FROM lms_lecture WHERE lvl_code=? ORDER BY lms_num";
				this.pstmt = this.conn.prepareStatement(sql);
				this.pstmt.setInt(1, i+1);
				this.rs = this.pstmt.executeQuery();
				List<Lms_lectureVO> listLecture = new ArrayList<>();
				while (this.rs.next() && this.rs.getString("lms_num")!=null) {
					Lms_lectureVO lecture = new Lms_lectureVO();
					lecture.setLms_num(this.rs.getString("lms_num"));
					lecture.setLvl_code(this.rs.getInt("lvl_code"));
					lecture.setFname(this.rs.getString("fname"));
					lecture.setDuration(this.rs.getString("duration"));
					lecture.setDescription(this.rs.getString("description"));
					listLecture.add(lecture);
					mapListLecture.put(i, listLecture);
				}
			}
			return mapListLecture;
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return null;
	}
	public Lms_lectureVO getLecture(String lms_num) {
		getConn();
		try {
			String sql = "SELECT * FROM lms_lecture WHERE lms_num=?";
			this.pstmt = conn.prepareStatement(sql);
			this.pstmt.setString(1, lms_num);
			this.rs = this.pstmt.executeQuery();
			if (this.rs.next()) {
				Lms_lectureVO lecture = new Lms_lectureVO();
				lecture.setLms_num(this.rs.getString("lms_num"));
				lecture.setLvl_code(this.rs.getInt("lvl_code"));
				lecture.setFname(this.rs.getString("fname"));
				lecture.setDuration(this.rs.getString("duration"));
				lecture.setDescription(this.rs.getString("description"));
				return lecture;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
		return null;
	}
	public void initStatus(String userid) {
		try {
			getConn();
			String sql = "INSERT INTO lms_status (userid,lvl_code,lms_num) VALUES (?,?,?)";
			this.pstmt = this.conn.prepareStatement(sql);
			this.pstmt.setString(1, userid);
			this.pstmt.setInt(2, 1);
			this.pstmt.setString(3, "1.1");
			this.pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			closeAll();
		}
	}
	// 김정은 
	public List<Lms_testVO> getTest(Lms_testVO testVO)
	{
		getConn();

		String sql = "SELECT * FROM get_lms WHERE lms_num=?";

		try {
			this.pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, testVO.getLms_num());
			this.rs=pstmt.executeQuery();

			List<Lms_testVO> list = new ArrayList<>();

			while(rs.next()) 
			{
				String lms_num = rs.getString("lms_num");
				int lms_tnum = rs.getInt("lms_tnum");
				String lms_question = rs.getString("lms_question");
				String lms_anum = rs.getString("lms_anum");
				//추가
				int lms_qid = this.rs.getInt("lms_qid");
				int lms_aid = this.rs.getInt("lms_aid");
				//

				Lms_testVO test = new Lms_testVO();
				test.setLms_num(lms_num);
				test.setLms_tnum(lms_tnum);
				test.setLms_question(lms_question);
				test.setLms_anum(lms_anum);
				// 추가
				test.setLms_qid(lms_qid);
				test.setLms_aid(lms_aid);
				//

				list.add(test);
			}
			return list;

		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return null;
	}
	public boolean addans(Lms_statusVO lms)
	{
		getConn();
		try {
			String sql="INSERT INTO lms_status(lms_qid,lms_num,lms_tnum,lms_question,"
					+ "lms_anum,lms_aid,userid, test_date,lvl_code)"
					+ "VALUES (?,?,?,?,?,?,?,localtimestamp,?)";
			this.pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lms.getLms_qid());
			pstmt.setString(2, lms.getLms_num());
			pstmt.setInt(3, lms.getLms_tnum());
			pstmt.setString(4, lms.getLms_question());
			pstmt.setString(5, lms.getLms_anum());
			pstmt.setInt(6, lms.getLms_aid());
			pstmt.setString(7, lms.getUserid());
			pstmt.setInt(8, lms.getLvl_code());

			int rows=pstmt.executeUpdate();
			return rows>0?true:false;

		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return false;
	}
	public boolean updateans(Lms_statusVO lms)
	{
		getConn();
		try {
			String sql="UPDATE lms_status SET lms_aid=?, lms_anum=?, test_date=localtimestamp WHERE userid=? AND lms_qid=?";
			this.pstmt = conn.prepareStatement(sql);
			
			System.out.println("updateans():lms:"+lms);
			
			pstmt.setInt(1, lms.getLms_aid());
			pstmt.setString(2, lms.getLms_anum());
			pstmt.setString(3, lms.getUserid());
			pstmt.setInt(4, lms.getLms_qid());

			int rows=pstmt.executeUpdate();
			System.out.println("updateans:rows:"+(rows>0?true:false));
			return rows>0?true:false;

		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return false;
	}
	// 왕종빈
	public boolean setStatus(List<Lms_statusVO> vo) {
		getConn();
		try {
			System.out.println(vo);
			
			String sql = "UPDATE lms_status SET t_feedback=?, pass=? "
					+ "WHERE lms_num =? AND lvl_code = ? AND lms_tnum = ? AND userid=?";
			
			
			for(int i = 0; i<vo.size() ; i++) {
				
				this.pstmt = conn.prepareStatement(sql);
				
				String pass = boolToString(vo.get(i).isPass());
				
				pstmt.setString(1, vo.get(i).getT_feedback());
				
				System.out.println("1" + vo.get(i).getT_feedback() + " ");
				
				pstmt.setString(2, pass);
				
				pstmt.setString(3, vo.get(i).getLms_num());
				pstmt.setInt(4, vo.get(i).getLvl_code());
				pstmt.setInt(5, vo.get(i).getLms_tnum());
				System.out.println("vo.get(i).getLms_tnum():"+vo.get(i).getLms_tnum());
				System.out.println("getLms_tnum"+vo.get(i).getLms_tnum());
				pstmt.setString(6, vo.get(i).getUserid());
				if(pstmt.executeUpdate()!=1) return false;
			}
			return true;
			
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return false;
	}
	
	public Lms_statusVO getuser(String userid, int lms_num, int lvl_num) {
		getConn();
		
		try {
			String sql = "SELECT lms_num, userid, lvl_code, test_date From lms_status WHERE userid=? AND lms_num = ? AND lvl_code = ?";
			
			this.pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setInt(2, lms_num);
			pstmt.setInt(3, lvl_num);

			Lms_statusVO vo = new Lms_statusVO();
			this.rs = pstmt.executeQuery();
			while(rs.next())
			{
				String id = rs.getString("userid");
				String l_num = rs.getString("lms_num");
				int lv_code = rs.getInt("lvl_code");
				java.sql.Timestamp test_date = rs.getTimestamp("test_date");
				
				vo.setUserid(id);
				vo.setLms_num(l_num);
				vo.setLvl_code(lv_code);
				vo.setTest_date(test_date);
			}
			return vo;
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return null;
	}
	
	public List<Lms_statusVO> getStatus(String userid, String l_num, int lv_num ) 
	{
		System.out.println("DAO getStatus");
		getConn();
		try {
			String sql = "SELECT lms_num, lms_tnum, lms_question, lms_anum, userid, lvl_code From lms_status WHERE userid=? AND lms_num = ? AND lvl_code = ?";
			
			this.pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, l_num);
			pstmt.setInt(3, lv_num);
			
			this.rs = pstmt.executeQuery();

			List<Lms_statusVO> list = new ArrayList<>();
			
			while(rs.next()) 
			{
				String lms_num = rs.getString("lms_num");
				int lms_tnum = rs.getInt("lms_tnum");
				String lms_question = rs.getString("lms_question");
				String Lms_anum = rs.getString("Lms_anum");	
				int lvl_code = rs.getInt("lvl_code");
				
				System.out.println(lms_num);
				System.out.println(lms_tnum);
				System.out.println(lms_question);
				System.out.println(Lms_anum);
				System.out.println(lvl_code);
				
				Lms_statusVO stus = new Lms_statusVO();
				stus.setLms_num(lms_num);
				stus.setLms_tnum(lms_tnum);
				stus.setLms_question(lms_question);
				stus.setLms_anum(Lms_anum);
				stus.setUserid(userid);
				stus.setLvl_code(lvl_code);
				
				list.add(stus);
			}
			return list;
		} catch (SQLException e) {
			
			e.printStackTrace();
		}finally {
			closeAll();
		}
		return null;
	}
	public List<Lms_statusVO> getStatusList2() 
	{
		getConn();
		String sql="SELECT * FROM lms_status";
		try {
			this.stmt=conn.createStatement();
			this.rs=stmt.executeQuery(sql);
			List<Lms_statusVO> list = new ArrayList<>();
			while(rs.next())
			{
				String userid =rs.getString("userid");
				String lms_num = rs.getString("lms_num");
				//System.out.println("lms_num: "+lms_num);
				int lvl_code = rs.getInt("lvl_code");
				//System.out.println("["+lvl_code+"]"+"lvl_code"+rs.getInt("lvl_code"));
				int lms_tnum = rs.getInt("lms_tnum");
				java.sql.Timestamp test_date = rs.getTimestamp("test_date");
				String lms_anum = rs.getString("lms_anum");
				String t_feedback = rs.getString("t_feedback");
				//boolean pass = Integer.valueOf(rs.getString("pass").trim())==1?true:false;
				//System.out.println("pass: "+Integer.valueOf(rs.getString("pass").strip()));
				//System.out.println("pass 값:"+pass);
				//System.out.println("여기"+"lvl_code: "+lvl_code+test_date);
				Lms_statusVO lms = new Lms_statusVO();
				lms.setUserid(userid);
				lms.setLms_num(lms_num);
				lms.setLvl_code(lvl_code);
				lms.setLms_tnum(lms_tnum);
				lms.setTest_date(test_date);
				lms.setLms_anum(lms_anum);
				lms.setT_feedback(t_feedback);
				//lms.setPass(pass);
				
				list.add(lms);				
			}
			//System.out.println("지금여기");
			return list;		
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeAll();
		}
		
		return null;
	}
	static String boolToString(boolean b) {
        if(b) {
            return "1";
        }
        return "0";
    }
	
	private void getConn() {
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			this.conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","SCOTT","TIGER");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	private void closeAll()
	{
		try 
		{
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
			if(pstmt!=null) pstmt.close();
			if(conn!=null) conn.close();
		} catch (Exception e) {
			e.printStackTrace();;
		}	
	}
}
