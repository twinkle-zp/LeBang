package com.plat.entity;

import java.util.Date;

public class Traffic {
    private Integer id;

    private Date start;

    private Date end;

    private Integer uid;

    private String content;

    private Integer flag;

    private Integer tid;

    private Integer joinnum;

    private Integer neednum;

    private String phone;

    private String tname;   //类别名

    private String startString;

    private String endString;

    public String getEndString() {
        return endString;
    }

    public void setEndString(String endString) {
        this.endString = endString;
    }

    public String getStartString() {
        return startString;
    }

    public void setStartString(String startString) {
        this.startString = startString;
    }

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getStart() {
        return start;
    }

    public void setStart(Date start) {
        this.start = start;
    }

    public Date getEnd() {
        return end;
    }

    public void setEnd(Date end) {
        this.end = end;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }

    public Integer getTid() {
        return tid;
    }

    public void setTid(Integer tid) {
        this.tid = tid;
    }

    public Integer getJoinnum() {
        return joinnum;
    }

    public void setJoinnum(Integer joinnum) {
        this.joinnum = joinnum;
    }

    public Integer getNeednum() {
        return neednum;
    }

    public void setNeednum(Integer neednum) {
        this.neednum = neednum;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}