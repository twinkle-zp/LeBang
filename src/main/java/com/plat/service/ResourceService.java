package com.plat.service;

import com.plat.entity.Page;
import com.plat.entity.Resource;

public interface ResourceService {
    void upload(Resource resource);

    Page findList(String currPage);

    Page findMyList(String currPage, Integer uid);

    void addNum(Integer id);

    void delete(Integer valueOf);
}
