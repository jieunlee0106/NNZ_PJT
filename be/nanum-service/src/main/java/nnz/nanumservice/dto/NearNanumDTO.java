package nnz.nanumservice.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class NearNanumDTO implements Comparable<NearNanumDTO> {

    private Double distance;

    private NanumDTO nanumDTO;

    @Override
    public int compareTo(NearNanumDTO o) {
        return (int) (this.distance - o.getDistance());
    }
}
