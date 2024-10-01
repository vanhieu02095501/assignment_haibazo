package com.project.haibazoshop.repositories;

import com.project.haibazoshop.models.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ProductRespository extends JpaRepository<Product,Long> {


    @Query("SELECT p FROM Product p " +
            "JOIN p.variants v " + // Join với bảng ProductVariant thông qua quan hệ `variants`
            "WHERE (:keyword IS NULL OR p.name LIKE %:keyword%) " +
            "AND (:categoryId IS NULL OR p.category.id = :categoryId) " +
            "AND (:colorId IS NULL OR v.color.id = :colorId) " +  // Lọc theo colorId trong ProductVariant
            "AND (:sizeId IS NULL OR v.size.id = :sizeId) " +     // Lọc theo sizeId trong ProductVariant
            "AND (:styleId IS NULL OR v.style.id = :styleId) " +  // Lọc theo styleId trong ProductVariant
            "AND (:minPrice IS NULL OR p.price >= :minPrice) " +  // Lọc theo giá tối thiểu
            "AND (:maxPrice IS NULL OR p.price <= :maxPrice)")    // Lọc theo giá tối đa
    Page<Product> findAllWithFilters(@Param("keyword") String keyword,
                                     @Param("categoryId") Long categoryId,
                                     @Param("colorId") Long colorId,
                                     @Param("sizeId") Long sizeId,
                                     @Param("styleId") Long styleId,
                                     @Param("minPrice") Float minPrice,
                                     @Param("maxPrice") Float maxPrice,
                                     Pageable pageable);



}
