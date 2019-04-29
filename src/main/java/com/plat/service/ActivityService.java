package com.plat.service;

import com.plat.entity.Activity;
import com.plat.entity.ActivityCategory;

import java.util.List;

public interface ActivityService {
    List<ActivityCategory> findAll();

    void add(Activity activity);
}
