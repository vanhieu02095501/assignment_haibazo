package com.project.haibazoshop.services.impl;

import com.project.haibazoshop.dtos.CategoryDTO;
import com.project.haibazoshop.models.Category;
import com.project.haibazoshop.repositories.CategoryRepository;
import com.project.haibazoshop.services.ICategoryService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CategoryService implements ICategoryService {

    @Autowired
    CategoryRepository categoryRepository;

    @Override
    @Transactional
    public Category createCategory(CategoryDTO categoryDTO) {
        Category newCategory = Category
                .builder()
                .name(categoryDTO.getName())
                .build();
        return categoryRepository.save(newCategory);
    }

    @Override
    public Category getCategoryById(long id) {
        return categoryRepository.findById(id)
                .orElseThrow(()->new RuntimeException("Category not found."));
    }

    @Override
    public List<Category> getAllCategory() {

        return categoryRepository.findAll();
    }

    @Override
    @Transactional
    public Category updateCategory(long id, CategoryDTO categoryDTO) {
        Category existingCategory = getCategoryById(id);
        existingCategory.setName(categoryDTO.getName());

        categoryRepository.save(existingCategory);

        return existingCategory;
    }

    @Override
    @Transactional
    public void deleteCategoy(long id) {
        categoryRepository.deleteById(id);

    }
}
