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
@Table(name = "order_details")
public class OrderDetail extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;  // ID duy nhất của chi tiết đơn hàng

    @ManyToOne
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;  // Khóa ngoại tham chiếu đến bảng orders

    @ManyToOne
    @JoinColumn(name = "product_variant_id")
    private ProductVariant productVariant;  // Khóa ngoại tham chiếu đến bảng product_variants

    @Column(nullable = false)
    private Integer quantity;  // Số lượng sản phẩm được đặt

    @Column(nullable = false)
    private Double price;  // Giá của sản phẩm tại thời điểm đặt hàng

    @Column(nullable = false)
    private Integer discount;  // Phần trăm giảm giá tại thời điểm đặt hàng

    @Column(nullable = false, updatable = false)
    private Double total;  // Tổng tiền cho sản phẩm này


}