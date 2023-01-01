package com.ezen.servlet.lms;

import java.io.*;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class LmsService {
	HttpServletRequest request;
	HttpServletResponse response;
	String path = "/WEB-INF/jsp/lms/";

	public LmsService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public String service() {
		String view = null;
		String cmd = request.getParameter("cmd");
		System.out.println("cmd:" + cmd);
		if (cmd == null || cmd.equals("main")) {
			List<Lms_statusVO> listStatus = getStatus3();
			request.setAttribute("listStatus", listStatus);
			List<Lms_subjectVO> listSubject = getListSubject();
			request.setAttribute("listSubject", listSubject);
			Map<Integer, List<Lms_lectureVO>> mapListLecture = getMapListLecture();
			request.setAttribute("mapListLecture", mapListLecture);
			view = path + "lmsMain.jsp";
		} else if (cmd.equals("learning")) {
			String lms_num = request.getParameter("lms_num") != null ? request.getParameter("lms_num") : "";
			if (lms_num.equals("1.1")) {
				out(json("result", "학습을 시작합니다."));
				request.getSession().setAttribute("lms_num", lms_num);
			} else {
				int pqid = getQid(lms_num);
				int qidPass = getQidPass();
				// 통과한 강의 보다 한 단계 높은 강의 이하의 강의를 볼 수 있게 한다.
				if ((qidPass/3) + 1 >= (pqid/3)) {
					request.getSession().setAttribute("lms_num",lms_num);
					out(json("result","학습을 시작합니다."));
				} else {
					out(json("result","이전 강의를 학습하세요."));
				}
			}
		} else if (cmd.equals("video")) {
			String lms_num = request.getParameter("lms_num") != null ? request.getParameter("lms_num") : "";
			if (request.getSession().getAttribute("lms_num") != null
					&& ((String) request.getSession().getAttribute("lms_num")).equals(lms_num)) {
				request.setAttribute("video", getLecture());
				view = path + "lmsVideo.jsp";
			}
		}
		// 김정은
		else if (cmd.equals("test")) {
			String lms_num = request.getParameter("lms_num"); // video에서 넘어오는 값
			request.setAttribute("video", getLecture(lms_num));
			return path + "lms_test.jsp";
		}
		else if (cmd.equals("getTest")) // 강의 번호를 받아와서 DAO에 보내고, DAO에서 문제 데이터 불러오기
		{
			
			String lms_num = request.getParameter("lms_num"); // video에서 넘어오는 값
			Lms_testVO testVO = new Lms_testVO();
			testVO.setLms_num(lms_num);
			List<Lms_testVO> list = getTest(testVO);

			JSONArray jsArr = new JSONArray();
			for (int i = 0; i < list.size(); i++) {
				testVO = list.get(i);
				JSONObject jsObj = new JSONObject();

				jsObj.put("lms_tnum", testVO.getLms_tnum());
				jsObj.put("lms_question", testVO.getLms_question());
				jsObj.put("lms_anum", testVO.getLms_anum());

				// 추가
				jsObj.put("lms_qid", testVO.getLms_qid());
				jsObj.put("lms_aid", testVO.getLms_aid());
				//

				jsArr.add(jsObj);
			}
			String jsonStr = jsArr.toJSONString();
			responseJSONStr(jsonStr);

		} else if (cmd.equals("addans")) {
			System.out.println("lms_qid-1:"+request.getParameter("lms_qid-1"));
			boolean added = addans();
			JSONObject jsObj = new JSONObject();
			jsObj.put("submitted", added);
			responseJSONStr(jsObj.toJSONString());
		}

		return view;
	}
	public String adminService() {
		// 왕종빈
		String cmd = request.getParameter("cmd");

		if (cmd == null || cmd.equals("lmsStatus") || cmd.equals("main"))
		{
			List<Lms_statusVO> list = getStatusList();
			request.setAttribute("list", list);					
			return path + "/lmsStatus.jsp";
		}
		else if(cmd.equals("scoring"))
		{
			Lms_statusVO vo = getUser();
			request.setAttribute("vo", vo);

			List<Lms_statusVO> Status = getStatus();
			request.setAttribute("Status", Status);
			return path + "lmsScoring.jsp";
		}
		else if(cmd.equals("result"))
		{
			boolean Status = setStatus();
			JSONObject jsObj = new JSONObject();
			jsObj.put("Status", Status);
			responseJSONStr(jsObj.toJSONString());
		}
		return null;
	}

	private List<Lms_subjectVO> getListSubject() {
		return new LmsDAO().getListSubject();
	}

	private Map<Integer, List<Lms_lectureVO>> getMapListLecture() {
		return new LmsDAO().getMapListLecture();
	}

	private void out(String result) {
		try {
			response.getWriter().print(result);
			response.flushBuffer();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String json(String key, String value) {
		return "{\"" + key + "\":\"" + value + "\"}";
	}

	private int getLms_numToInt(String lms_num) {
		int num = Integer.valueOf(""+lms_num.charAt(0) + lms_num.charAt(2));
		return num;
	}

	private Lms_lectureVO getLecture(String lms_num) {
		return new LmsDAO().getLecture(lms_num);
	}

	private String getSessionLms_num() {
		return request.getSession().getAttribute("lms_num") != null
				? (String) request.getSession().getAttribute("lms_num")
						: null;
	}

	public void responseJSONStr(String jsonStr) {
		try {
			PrintWriter out = response.getWriter();
			out.print(jsonStr);
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	// 김정은
	public List<Lms_testVO> getTest(Lms_testVO testVO) {
		LmsDAO dao = new LmsDAO();
		List<Lms_testVO> list = dao.getTest(testVO);
		return list;
	}

	public boolean addans() {
		String lms_num = request.getParameter("lms_num");
		if (getStatus(lms_num).size()==0) {
			for (int i = 0; i < 3; i++) {
				Lms_statusVO lms = getParameterLms(i);

				LmsDAO dao = new LmsDAO();
				if (!dao.addans(lms)) {
					return false;
				}
			}
		} else {
			for (int i = 0; i < 3; i++) {
				Lms_statusVO lms = getParameterLms(i);

				LmsDAO dao = new LmsDAO();
				if (!dao.updateans(lms)) {
					return false;
				}
			}
		}
		return true;
	}
	private Lms_statusVO getParameterLms(int i) {
		int qid = Integer.parseInt(request.getParameter("lms_qid-" + (i + 1))); // 확인
		String num = request.getParameter("lms_num"); // 확인
		// int tnum= Integer.parseInt(request.getParameter("lms_tnum")); // 확인
		int tnum = i + 1; // 확인
		String question = request.getParameter("lms_question-" + (i + 1)); // 확인
		String anum = request.getParameter("lms_anum-" + (i + 1)); // 확인
		int aid = Integer.parseInt(request.getParameter("lms_aid-" + (i + 1))); // 확인
		String userid = request.getParameter("userid"); // 확인
		int lvl_code = Integer.parseInt(request.getParameter("lvl_code")); // 확인

		Lms_statusVO lms = new Lms_statusVO();

		lms.setLms_qid(qid);
		lms.setLms_num(num);
		lms.setLms_tnum(tnum);
		lms.setLms_question(question);
		lms.setLms_anum(anum);
		lms.setLms_aid(aid);
		lms.setUserid(userid);
		lms.setLvl_code(lvl_code);

		return lms;
	}

	private Lms_lectureVO getLecture() {
		String lms_num = getSessionLms_num();
		return new LmsDAO().getLecture(lms_num);
	}

	// 왕종빈
	private List<Lms_statusVO> getStatusList() {
		LmsDAO dao = new LmsDAO();
		return dao.getStatusList();
	}

	private boolean setStatus() {
		for (int i = 0; i < 3; i++) {
			Lms_statusVO vo = new Lms_statusVO();

			String feedback = request.getParameter("feedback" + i);
			String result = request.getParameter("result");
			String userid = request.getParameter("userid");
			int lms_tnum = Integer.valueOf(request.getParameter("lms_tnum" + i));
			String lms_num = request.getParameter("lms_num");
			int lvl_code = Integer.valueOf(request.getParameter("lvl_code"));

			boolean pass = Integer.valueOf(result.trim()) == 1 ? true : false;

			vo.setT_feedback(feedback);
			vo.setPass(pass);
			vo.setLms_tnum(lms_tnum);
			vo.setLms_num(lms_num);
			vo.setLvl_code(lvl_code);
			vo.setUserid(userid);

			if (!new LmsDAO().updateStatus(vo)) return false;
		}
		return true;
	}

	public Lms_statusVO getUser() {
		String userid = request.getParameter("userid");
		String lms_num = request.getParameter("lms_num");
		int lvl_num = Integer.valueOf(request.getParameter("lvl_code"));

		LmsDAO dao = new LmsDAO();
		Lms_statusVO vo = dao.getuser(userid, lms_num, lvl_num);
		return vo;
	}

	public int getQidPass() {
		String userid = (String)request.getSession().getAttribute("id");

		return new LmsDAO().getQidPass(userid);
	}
	private List<Lms_statusVO> getStatus() {
		String userid = request.getParameter("userid");
		String lms_num = request.getParameter("lms_num");
		int lvl_code = Integer.parseInt(request.getParameter("lvl_code"));
		LmsDAO dao = new LmsDAO();
		return dao.getStatusList(userid,lms_num,lvl_code);
	}
	private List<Lms_statusVO> getStatus(String lms_num) {
		String userid = (String)request.getSession().getAttribute("id");
		LmsDAO dao = new LmsDAO();
		return dao.getStatusList(userid, lms_num);
	}
	private List<Lms_statusVO> getStatus3() {
		String userid = (String)request.getSession().getAttribute("id");
		LmsDAO dao = new LmsDAO();
		return dao.getStatusList3(userid);
	}
	private int getQid(String lms_num) {
		return new LmsDAO().getQid(lms_num);
	}
}
