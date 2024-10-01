package com.project.haibazoshop.services.impl;

import com.project.haibazoshop.dtos.ProductDTO;
import com.project.haibazoshop.dtos.ProductImageDTO;
import com.project.haibazoshop.dtos.ProductVariantDTO;
import com.project.haibazoshop.exceptions.DataNotFindException;
import com.project.haibazoshop.exceptions.InvalidParamException;
import com.project.haibazoshop.models.*;
import com.project.haibazoshop.repositories.*;
import com.project.haibazoshop.responses.ProductResponse;
import com.project.haibazoshop.services.IProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProductService implements IProductService {

    @Autowired
    ProductRespository productRepository;

    @Autowired
    CategoryRepository categoryRepository;

    @Autowired
    SizeRepository sizeRepository;

    @Autowired
    StyleRepository styleRepository;

    @Autowired
    ColorRepository colorRepository;


    @Autowired
    ProductVariantRepository productVariantRepository;

    @Autowired
    ProductImageRespository productImageRespository;


    @Override
    public Product getProductById(long id) throws DataNotFindException {

        return productRepository.findById(id)
                .orElseThrow(()->new DataNotFindException("Can't find product id:"+ id));

    }


    @Override
    public ProductResponse getProductDetails(Long productId) throws Exception {
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new DataNotFindException("Can't find product with id: " + productId));

        // Chuyển đổi Product sang ProductResponse
        return ProductResponse.fromProduct(product) ;
    }



    @Transactional
    public void createProduct(ProductDTO productDTO) throws Exception {

        Category existingCategory = categoryRepository.findById(productDTO.getCategoryId())
                .orElseThrow(()->new DataNotFindException("Category not found"));
        // Tạo mới một Product entity từ request
        Product product = Product
                .builder()
                .name(productDTO.getName())
                .price(productDTO.getPrice())
                .category(existingCategory)
                .description(productDTO.getDescription())
                .quantity(productDTO.getQuantity())
                .thumbnail(productDTO.getThumbnail())
                .build();


        // Lưu sản phẩm vào database
        Product savedProduct = productRepository.save(product);

        // Tạo các biến thể sản phẩm từ request và lưu chúng
        if (productDTO.getVariants() != null && !productDTO.getVariants().isEmpty()) {
            for (ProductVariantDTO variantDTO : productDTO.getVariants()) {

                Style existStyle = styleRepository.findById(variantDTO.getStyleId())
                        .orElseThrow(()->new DataNotFindException("Style not found"));

                Color existColor = colorRepository.findById(variantDTO.getColorId())
                        .orElseThrow(()->new DataNotFindException("Color not found"));

                Size existSizeProduct = sizeRepository.findById(variantDTO.getSizeId())
                        .orElseThrow(()->new DataNotFindException("Size not found"));

                ProductVariant productVariant = ProductVariant
                        .builder()
                        .style(existStyle)
                        .color(existColor)
                        .product(savedProduct)
                        .size(existSizeProduct)
                        .quantity(variantDTO.getQuantity())
                        .build();


                productVariantRepository.save(productVariant);
            }
        }
    }



    @Override
    public ProductImage createProductImage(Long productId, ProductImageDTO productImageDTO) throws Exception {
        Product existingProduct = productRepository.findById(productId)
                .orElseThrow(() -> new DataNotFindException("Can't find product with id:" + productId));

        // Kiểm tra ảnh tồn tại
        List<ProductImage> existingImages = productImageRespository.findByProductId(productId);

        // Kiểm tra số lượng ảnh
        if (existingImages.size() >= ProductImage.MAXIMUM_IMAGES_PER_PRODUCTS) {
            throw new InvalidParamException("Number of images must be <= " + ProductImage.MAXIMUM_IMAGES_PER_PRODUCTS);
        }

        // Tạo ảnh sản phẩm
        ProductImage productImage = ProductImage.builder()
                .product(existingProduct)
                .imageUrl(productImageDTO.getImageUrl())
                .build();

        return productImageRespository.save(productImage);
    }

    @Override
    public Page<ProductResponse> getAllProducts(String keyword, Long categoryId, Long colorId, Long sizeId, Long styleId, Float minPrice, Float maxPrice, PageRequest pageRequest) {
        Page<Product> productPage;
        productPage = productRepository.findAllWithFilters(keyword, categoryId, colorId, sizeId, styleId, minPrice, maxPrice, pageRequest);

        return productPage.map(ProductResponse::fromProduct);
    }



}
