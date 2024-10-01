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
@Table(name = "orders")
public class Order extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;  // ID đơn hàng

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;  // Khóa ngoại tham chiếu đến bảng users

    @Column(nullable = false)
    private String address;  // Địa chỉ giao hàng

    @Column(nullable = false)
    private String phone;  // Số điện thoại liên hệ

    @Column(nullable = false)
    private Double amount;  // Tổng số tiền của đơn hàng

    @Column(name = "order_date", nullable = false, updatable = false)
    private java.sql.Timestamp orderDate;  // Ngày đặt hàng

    @Column(nullable = false)
    private Integer status;  // Trạng thái đơn hàng


}