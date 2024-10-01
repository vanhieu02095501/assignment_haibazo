package com.project.haibazoshop.services;

import com.project.haibazoshop.dtos.CategoryDTO;
import com.project.haibazoshop.models.Category;

import java.util.List;

public interface ICategoryService {

    Category createCategory (CategoryDTO categoryDTO);
    Category getCategoryById (long id);

    List<Category> getAllCategory();
    Category updateCategory(long id,CategoryDTO categoryDTO);
    void deleteCategoy(long id);
}
