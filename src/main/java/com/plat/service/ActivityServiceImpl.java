package com.plat.service;

import com.plat.dao.ActivityCategoryMapper;
import com.plat.dao.ActivityMapper;
import com.plat.entity.Activity;
import com.plat.entity.ActivityCategory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityCategoryMapper activityCategoryMapper;

    @Autowired
    private ActivityMapper activityMapper;

    public List<ActivityCategory> findAll() {

        return activityCategoryMapper.findAll();
    }

    public void add(Activity activity) {
        activityMapper.insert(activity);
    }
}
