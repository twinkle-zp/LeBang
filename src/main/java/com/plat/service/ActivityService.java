package com.plat.service;

import com.plat.entity.Activity;
import com.plat.entity.ActivityCategory;
import com.plat.entity.Page;

import java.util.List;

public interface ActivityService {
    List<ActivityCategory> findAll();

    void add(Activity activity);

    Page findList(String currPage);
}
