package com.project.haibazoshop.responses;


import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductVariantResponse {
    private Long id;                 // ID của biến thể sản phẩm

    @JsonProperty("color_id")
    private Long colorId;            // ID của màu sắc sản phẩm

    @JsonProperty("size_id")
    private Long sizeId;             // ID của kích thước sản phẩm

    @JsonProperty("style_id")
    private Long styleId;            // ID của kiểu dáng sản phẩm

    private Integer quantity;        // Số lượng của biến thể sản phẩm

    // Getters và Setters
}