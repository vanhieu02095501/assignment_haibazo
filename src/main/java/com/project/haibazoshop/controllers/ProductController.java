package com.project.haibazoshop.controllers;

import com.project.haibazoshop.dtos.ProductDTO;
import com.project.haibazoshop.dtos.ProductImageDTO;
import com.project.haibazoshop.models.Product;
import com.project.haibazoshop.models.ProductImage;
import com.project.haibazoshop.responses.ProductListResponse;
import com.project.haibazoshop.responses.ProductResponse;
import com.project.haibazoshop.services.impl.ProductService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

@RestController
@RequestMapping("${api.prefix}/products")
public class ProductController {

    @Autowired
    ProductService productService;

    @GetMapping("/{productId}")
    public ResponseEntity<ProductResponse> getProductDetails(@PathVariable Long productId) throws Exception {
        ProductResponse productResponse = productService.getProductDetails(productId);
        return ResponseEntity.ok(productResponse);
    }

    @GetMapping("")
    public ResponseEntity<ProductListResponse> getProducts(
            @RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "2", name = "categoryId") Long categoryId,
            @RequestParam(defaultValue = "", name = "colorId") Long colorId,
            @RequestParam(defaultValue = "", name = "sizeId") Long sizeId,
            @RequestParam(defaultValue = "", name = "styleId") Long styleId,
            @RequestParam(defaultValue = "0", name = "minPrice") Float minPrice,   // thêm tham số minPrice
            @RequestParam(defaultValue = "9999999", name = "maxPrice") Float maxPrice,  // thêm tham số maxPrice
            @RequestParam("page") int page,
            @RequestParam("limit") int limit
    ) {
        // Tạo pageable từ thông tin trang và giới hạn, sắp xếp các bản ghi theo id
        PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("id").ascending());

        // Chứa danh sách các đối tượng product tương ứng với trang được yêu cầu
        Page<ProductResponse> productPage = productService.getAllProducts(
                keyword, categoryId, colorId, sizeId, styleId, minPrice, maxPrice, pageRequest);

        // Lấy tổng số trang
        int totalPages = productPage.getTotalPages();

        // Lấy danh sách các bản ghi trong trang hiện tại
        List<ProductResponse> productResponses = productPage.getContent();

        return ResponseEntity.ok(ProductListResponse.builder()
                .productResponses(productResponses)
                .total(totalPages)
                .build());
    }


    @PostMapping(value = "")
    public ResponseEntity<?> createProduct(@Valid @RequestBody ProductDTO productDTO,
                                           BindingResult result) {
        try {
            if (result.hasErrors()) {
                List<String> messageErrors = result.getFieldErrors()
                        .stream()
                        .map(fieldError -> fieldError.getDefaultMessage())
                        .toList();
                return ResponseEntity.badRequest().body(messageErrors);
            }


            productService.createProduct(productDTO);

            return ResponseEntity.ok().body("Product created successfully");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }


    }

    // kiểm tra có phải file ảnh hay không
    private boolean isImageFile(MultipartFile file) {
        String contentType = file.getContentType();
        return contentType != null && contentType.startsWith("image/");

    }


    @GetMapping("/images/{imageName}")
    private ResponseEntity<?> viewImage(@PathVariable("imageName") String imageName) {

        try {
            Path imagePath = Paths.get("uploads/" + imageName);
            UrlResource resource = new UrlResource(imagePath.toUri());

            if (resource.exists()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.IMAGE_JPEG)
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }

        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }

    }


    @PostMapping(value = "/uploads/{productId}",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> uploadFiles(
            @PathVariable("productId") Long productId,
            @RequestParam("files") List<MultipartFile> files
    ) {



        try {
            if (files.size() > ProductImage.MAXIMUM_IMAGES_PER_PRODUCTS) {
                return ResponseEntity.badRequest().body("You can only upload maximum 5 images.");
            }

            Product existingProduct = productService.getProductById(productId);
            List<ProductImage> productImages = new ArrayList<>();

            for (MultipartFile file : files) {
                // Nếu file có kích thước bằng 0 thì bỏ qua
                if (file.getSize() == 0) {
                    continue;
                }

                // Kiểm tra kích thước file và định dạng
                if (file.getSize() > 10 * 1024 * 1024) { // Kích thước tối đa 10MB
                    return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE)
                            .body("File is too large, Maximum of file is 10MB.");
                }

                String contentType = file.getContentType();
                if (contentType == null || !contentType.startsWith("image/")) {
                    return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                            .body("File must be an image.");
                }

                // Lưu file và tạo đối tượng ProductImage
                try {
                    ProductImage productImage = productService.createProductImage(productId,
                            ProductImageDTO.builder()
                                    .productId(productId)
                                    .imageUrl(storeFile(file))
                                    .build()
                    );

                    productImages.add(productImage);
                } catch (IOException e) {
                    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                            .body("Error saving image: " + e.getMessage());
                }
            }
            return ResponseEntity.ok(productImages);

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    //     hàm lưu file xong thì trả về tên file
    private String storeFile(MultipartFile file) throws IOException {

        if (!isImageFile(file) || file.getOriginalFilename() == null) {
            throw new IOException("Invalid image format.");
        }
        // làm sạch đường dẫn file tránh và lấy tên file gốc
        String fileName = StringUtils.cleanPath(Objects.requireNonNull(file.getOriginalFilename()));
        //thêm UUID.randomUUID() vào trước tên file để đảm bảo trên file là duy nhất
        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
        // đường dẫn bạn đến thư mục bạn muốn lưu file
        Path uploadDir = Paths.get("uploads");
        // kiểm tra có thứ mục uploads không ,nếu không thì tạo mới thư mục
        if (!Files.exists(uploadDir)) {
            Files.createDirectories(uploadDir);
        }
        // tạo ra đường dẫn đầy đủ bằng cách kết hợp đường dẫn thư mục đích (uploadDir) và tên tệp duy nhất (uniqueFileName).
        Path destination = Paths.get(uploadDir.toString(), uniqueFileName);

        // sao chép dữ liệu từ luồng đầu vào của tệp tải lên (file.getInputStream()) vào đường dẫn đích (destination).
        // Nếu tệp đích đã tồn tại, nó sẽ bị thay thế bởi tệp mới.
        Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);
        return uniqueFileName;
    }


}
