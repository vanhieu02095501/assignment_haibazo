package com.project.haibazoshop.dtos;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data // create getter & setter
@AllArgsConstructor
@NoArgsConstructor
public class CategoryDTO {

    @NotEmpty(message = "Category's name can't be empty")
    private String name;
}
