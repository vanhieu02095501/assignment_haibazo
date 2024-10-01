package com.project.haibazoshop.repositories;

import com.project.haibazoshop.models.ProductVariant;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductVariantRepository extends JpaRepository<ProductVariant,Long> {
}
