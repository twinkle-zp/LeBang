package com.plat.entity;

import java.util.List;

/**
 * 分页实体
 */
public class Page {
    private List list;

    private Integer currPage;//当前页
    private Integer totalPage;//总共多少页
    private Integer pageSize=12;//每页显示多少条数据
    private Integer totalCount;//总共多少条数据


    public List getList() {
        return list;
    }
    public void setList(List list) {
        this.list = list;
    }
    public Integer getCurrPage() {
        return currPage;
    }
    public void setCurrPage(Integer currPage) {
        this.currPage = currPage;
    }


    public Integer getTotalPage() {
        Double d = (double)totalCount/(double)pageSize;
        totalPage=(int) Math.ceil(d);

        return totalPage;
    }
    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }
    public Integer getPageSize() {
        return pageSize;
    }
    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }
    public Integer getTotalCount() {
        return totalCount;
    }
    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
    }


    public Integer getBeginRows() {
        return (this.getCurrPage()-1)*this.getPageSize();
    }
}
