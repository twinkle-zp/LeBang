package com.plat.service;

import com.plat.dao.ResourceMapper;
import com.plat.entity.Page;
import com.plat.entity.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ResourceServiceImpl implements ResourceService {

    @Autowired
    private ResourceMapper resourceMapper;

    public void upload(Resource resource) {
        resource.setFlag(0);
        resource.setLikenum(0);
        resource.setNum(0);
        resource.setState(0);
        resourceMapper.insert(resource);
    }

    public Page findList(String currPage) {
        if(currPage==null)
        {
            currPage = "1";
        }
        Page result = new Page();
        int totalCount = resourceMapper.getTotalCount();
        result.setTotalCount(totalCount);
        result.setCurrPage(Integer.valueOf(currPage));
        List<Resource> list = resourceMapper.findPage(result.getBeginRows(),result.getPageSize());
        //获取文件后缀名
        for(Resource r:list){
            String fileTyle=r.getAddress().substring(r.getAddress().lastIndexOf("."),r.getAddress().length());
            r.setSuffix(fileTyle);
        }
        result.setList(list);
        return result;
    }

    public Page findMyList(String currPage, Integer uid) {
        if(currPage==null)
        {
            currPage = "1";
        }
        Page result = new Page();
        int totalCount = resourceMapper.getMyTotalCount(uid);
        result.setTotalCount(totalCount);
        result.setCurrPage(Integer.valueOf(currPage));
        List<Resource> list = resourceMapper.findMyPage(result.getBeginRows(),result.getPageSize(),uid);
        //获取文件后缀名
        for(Resource r:list){
            String fileTyle=r.getAddress().substring(r.getAddress().lastIndexOf("."),r.getAddress().length());
            r.setSuffix(fileTyle);
        }
        result.setList(list);
        return result;
    }

    public void addNum(Integer id) {
        Resource resource = resourceMapper.selectByPrimaryKey(id);
        resource.setNum(resource.getNum()+1);
        resourceMapper.updateByPrimaryKey(resource);
    }

    public void delete(Integer valueOf) {
        resourceMapper.deleteByPrimaryKey(valueOf);
    }

    @Override
    public Page findAllList(String currPage) {
        if(currPage==null)
        {
            currPage = "1";
        }
        Page result = new Page();
        int totalCount = resourceMapper.getAllCount();
        result.setTotalCount(totalCount);
        result.setCurrPage(Integer.valueOf(currPage));
        List<Resource> list = resourceMapper.findAllPage(result.getBeginRows(),result.getPageSize());
        //获取文件后缀名
        for(Resource r:list){
            String fileTyle=r.getAddress().substring(r.getAddress().lastIndexOf("."),r.getAddress().length());
            r.setSuffix(fileTyle);
        }
        result.setList(list);
        return result;
    }

    @Override
    public int updateResource(Resource resource) {
        return resourceMapper.updateByPrimaryKeySelective(resource);
    }

    @Override
    public Page findListByName(String name) {

        Page result = new Page();
        name="%"+name+"%";    //拼接查询字符串
        int totalCount = resourceMapper.getTotalCountByName(name);
        result.setTotalCount(totalCount);
        result.setCurrPage(Integer.valueOf(1));
        List<Resource> list = resourceMapper.findPageByName(result.getBeginRows(),result.getPageSize(),name);
        //获取文件后缀名
        for(Resource r:list){
            String fileTyle=r.getAddress().substring(r.getAddress().lastIndexOf("."),r.getAddress().length());
            r.setSuffix(fileTyle);
        }
        result.setList(list);
        return result;
    }
}
