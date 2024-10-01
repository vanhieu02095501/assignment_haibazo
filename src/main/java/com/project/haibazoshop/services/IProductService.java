package com.project.haibazoshop.services;

import com.project.haibazoshop.dtos.ProductDTO;
import com.project.haibazoshop.dtos.ProductImageDTO;
import com.project.haibazoshop.exceptions.DataNotFindException;
import com.project.haibazoshop.models.Product;
import com.project.haibazoshop.models.ProductImage;
import com.project.haibazoshop.responses.ProductResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

public interface IProductService {
    Product getProductById(long id) throws DataNotFindException;

    void createProduct(ProductDTO createProductRequest) throws DataNotFindException, Exception;

    ProductImage createProductImage(Long productId, ProductImageDTO productImageDTO
    )throws Exception;

     ProductResponse getProductDetails(Long productId) throws DataNotFindException, Exception;

    Page<ProductResponse> getAllProducts(String keyword, Long categoryId, Long colorId, Long sizeId, Long styleId,Float minPrice, Float maxPrice, PageRequest pageRequest);
}
