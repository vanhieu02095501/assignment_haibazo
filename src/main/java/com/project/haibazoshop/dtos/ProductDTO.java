package com.project.haibazoshop.dtos;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProductDTO {

    @NotBlank(message = "Product name is required")
    private String name;

    @NotNull(message = "Price is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Price must be greater than 0")
    private Float price;

    @JsonProperty("category_id")
    private Long categoryId;

    private Integer quantity;

    private String thumbnail;

    private String description;

//    private List<MultipartFile> files;


    @NotNull(message = "Product variants cannot be null")
    @Size(min = 1, message = "At least one product variant is required")
    private List<ProductVariantDTO> variants; // Danh sách các biến thể sản phẩm
}