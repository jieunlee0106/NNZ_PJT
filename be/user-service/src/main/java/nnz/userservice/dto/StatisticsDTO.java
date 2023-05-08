package nnz.userservice.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.userservice.entity.Nanum;

import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class StatisticsDTO {

    private int totalCount;
    private int beforeCount;
    private int ongoingCount;
    private int doneCount;

    public static StatisticsDTO of(List<Nanum> nanums) {
        StatisticsDTO dto = new StatisticsDTO();
        dto.totalCount = nanums.size();
        for (Nanum nanum : nanums) {
            if (nanum.getStatus() == Nanum.NanumStatus.BEFORE || nanum.getStatus() == Nanum.NanumStatus.CLOSE) {
                dto.beforeCount++;
            } else if (nanum.getStatus() == Nanum.NanumStatus.ONGOING) {
                dto.ongoingCount++;
            } else if (nanum.getStatus() == Nanum.NanumStatus.FINISH) {
                dto.doneCount++;
            }
        }
        return dto;
    }
}
