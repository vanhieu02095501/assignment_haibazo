package com.project.haibazoshop.models;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "cart_details")
public class CartDetail extends BaseEntity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;  // ID duy nhất cho mỗi chi tiết giỏ hàng

    @ManyToOne
    @JoinColumn(name = "cart_id", nullable = false)
    private Cart cart;  // Khóa ngoại tham chiếu đến bảng carts

    @ManyToOne
    @JoinColumn(name = "product_variant_id", nullable = false)
    private ProductVariant productVariant;  // Khóa ngoại tham chiếu đến bảng product_variants

    @Column(nullable = false)
    private Integer quantity;  // Số lượng sản phẩm trong giỏ hàng


}