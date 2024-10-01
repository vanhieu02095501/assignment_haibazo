package com.project.haibazoshop.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "products")
public class Product extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;  // Thay Long bằng Integer vì bảng SQL sử dụng INT

    @Column(name = "name", nullable = false, length = 350)
    private String name;

    @Column(name = "price", nullable = false)
    private Float price;  // Giá chung cho tất cả các biến thể

    @Column(name = "thumbnail", nullable = false, length = 300)
    private String thumbnail;

    @Column(name = "discount", nullable = false)
    private Integer discount;  // Phần trăm giảm giá

    @Column(name = "description", length = 1000)
    private String description;

    @Column(name = "quantity", nullable = false)
    private Integer quantity;  // Tổng số lượng sản phẩm

    @Column(name = "sold", nullable = false)
    private Integer sold;  // Số lượng sản phẩm đã bán

    @Column(name = "status", nullable = false)
    private Boolean status;  // Trạng thái sản phẩm (1: Đang bán, 0: Ngừng bán)

    @ManyToOne
    @JoinColumn(name = "category_id")
    private Category category;  // Khóa ngoại tham chiếu đến danh mục

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ProductVariant> variants;

    @OneToMany(mappedBy = "product", cascade = CascadeType.ALL)
    private List<Rate> rates = new ArrayList<>();





    // Các trường created_at và updated_at có thể được kế thừa từ BaseEntity
}
