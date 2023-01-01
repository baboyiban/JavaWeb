package com.ezen.servlet.lms;

import java.sql.Timestamp;
import java.util.Objects;

public class Lms_statusVO 
{
   private String userid; // 아이디 
   private int lvl_code; // 과목 코드 1, 2, 3 
   private String lms_num; // 강의 번호 1.1, 1.2, 1.3 
   private java.sql.Timestamp  test_date; // 테스트를 본 날짜 
   private int lms_tnum; // 몇번째 문제 -1, -2, -3 한 강의당 총 3 문제 
   private int lms_qid; // 총 문제의 번호 총 27 
   private String lms_question; // 문제 
   private int lms_aid; // 답 번호 
   private String lms_anum; // 답 
   private String t_feedback; // 피드백 
   private int lms_scoring; // 점수 
   private boolean pass; //통과
   
   public Lms_statusVO() {}

   public Lms_statusVO(String userid, int lvl_code, String lms_num, Timestamp test_date, int lms_tnum, int lms_qid,
         String lms_question, int lms_aid, String lms_anum, String t_feedback, int lms_scoring, boolean pass) {
      super();
      this.userid = userid;
      this.lvl_code = lvl_code;
      this.lms_num = lms_num;
      this.test_date = test_date;
      this.lms_tnum = lms_tnum;
      this.lms_qid = lms_qid;
      this.lms_question = lms_question;
      this.lms_aid = lms_aid;
      this.lms_anum = lms_anum;
      this.t_feedback = t_feedback;
      this.lms_scoring = lms_scoring;
      this.pass = pass;
   }

   
   
   public String getUserid() {
      return userid;
   }

   public void setUserid(String userid) {
      this.userid = userid;
   }

   public int getLvl_code() {
      return lvl_code;
   }

   public void setLvl_code(int lvl_code) {
      this.lvl_code = lvl_code;
   }

   public String getLms_num() {
      return lms_num;
   }

   public void setLms_num(String lms_num) {
      this.lms_num = lms_num;
   }

   public java.sql.Timestamp getTest_date() {
      return test_date;
   }

   public void setTest_date(java.sql.Timestamp test_date) {
      this.test_date = test_date;
   }

   public int getLms_tnum() {
      return lms_tnum;
   }

   public void setLms_tnum(int lms_tnum) {
      this.lms_tnum = lms_tnum;
   }

   public int getLms_qid() {
      return lms_qid;
   }

   public void setLms_qid(int lms_qid) {
      this.lms_qid = lms_qid;
   }

   public String getLms_question() {
      return lms_question;
   }

   public void setLms_question(String lms_question) {
      this.lms_question = lms_question;
   }

   public int getLms_aid() {
      return lms_aid;
   }

   public void setLms_aid(int lms_aid) {
      this.lms_aid = lms_aid;
   }

   public String getLms_anum() {
      return lms_anum;
   }

   public void setLms_anum(String lms_anum) {
      this.lms_anum = lms_anum;
   }

   public String getT_feedback() {
      return t_feedback;
   }

   public void setT_feedback(String t_feedback) {
      this.t_feedback = t_feedback;
   }

   public int getLms_scoring() {
      return lms_scoring;
   }

   public void setLms_scoring(int lms_scoring) {
      this.lms_scoring = lms_scoring;
   }

   public boolean isPass() {
      return pass;
   }

   public void setPass(boolean pass) {
      this.pass = pass;
   }

   @Override
   public int hashCode() {
      return Objects.hash(lms_aid, lms_anum, lms_num, lms_qid, lms_question, lms_scoring, lms_tnum, lvl_code, pass,
            t_feedback, test_date, userid);
   }

   @Override
   public boolean equals(Object obj) {
      if (this == obj)
         return true;
      if (obj == null)
         return false;
      if (getClass() != obj.getClass())
         return false;
      Lms_statusVO other = (Lms_statusVO) obj;
      return lms_aid == other.lms_aid && Objects.equals(lms_anum, other.lms_anum)
            && Objects.equals(lms_num, other.lms_num) && lms_qid == other.lms_qid
            && Objects.equals(lms_question, other.lms_question) && lms_scoring == other.lms_scoring
            && lms_tnum == other.lms_tnum && lvl_code == other.lvl_code && pass == other.pass
            && Objects.equals(t_feedback, other.t_feedback) && Objects.equals(test_date, other.test_date)
            && Objects.equals(userid, other.userid);
   }

   @Override
   public String toString() {
      return "Lms_statusVO [userid=" + userid + ", lvl_code=" + lvl_code + ", lms_num=" + lms_num + ", test_date="
            + test_date + ", lms_tnum=" + lms_tnum + ", lms_qid=" + lms_qid + ", lms_question=" + lms_question
            + ", lms_aid=" + lms_aid + ", lms_anum=" + lms_anum + ", t_feedback=" + t_feedback + ", lms_scoring="
            + lms_scoring + ", pass=" + pass + "]";
   }

   

   

   
   
   
   
}