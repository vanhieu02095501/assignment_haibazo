package com.project.haibazoshop.responses;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductListResponse {

    private List<ProductResponse> productResponses;
    private int total;


}
