package nnz.nanumservice.dto.res;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ResNanumStockDTO {

    private Integer quantity;

    private Integer stock;

    public static ResNanumStockDTO of(Integer quantity, Integer stock) {
        return ResNanumStockDTO.builder()
                .quantity(quantity)
                .stock(stock)
                .build();
    }
}
