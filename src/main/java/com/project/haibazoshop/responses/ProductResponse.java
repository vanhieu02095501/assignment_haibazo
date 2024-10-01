package com.project.haibazoshop.responses;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.project.haibazoshop.models.Product;
import com.project.haibazoshop.models.Rate;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductResponse {

    private Long id;
    private String name;
    private Float price;
    @JsonProperty("category_id")
    private Long categoryId;
    private String description;
    @JsonProperty("average_rating")
    private double averageRating;  // Đánh giá sao trung bình
    @JsonProperty("rate_count")
    private int rateCount;

    private List<ProductVariantResponse> variants; // Danh sách các biến thể


    public static ProductResponse fromProduct(Product product){

        List<Rate> rates = product.getRates();
        int rateCount = rates.size();
        double averageRating = rates.stream()
                .mapToInt(Rate::getRating)
                .average()
                .orElse(0.0);  // Nếu không có đánh giá nào thì trả về 0


        List<ProductVariantResponse> variantResponses = product.getVariants().stream()
                .map(variant -> ProductVariantResponse.builder()
                        .id(variant.getId())
                        .colorId(variant.getColor().getId())
                        .sizeId(variant.getSize().getId())
                        .styleId(variant.getStyle().getId())
                        .quantity(variant.getQuantity())
                        .build())
                .collect(Collectors.toList());

        ProductResponse productResponse = ProductResponse.builder()
                .id(product.getId())
                .name(product.getName())
                .price(product.getPrice())
                .categoryId(product.getCategory().getId())
                .description(product.getDescription())
                .averageRating(averageRating)
                .rateCount(rateCount)
                .variants(variantResponses)
                .build();

        return productResponse;
    }
}
