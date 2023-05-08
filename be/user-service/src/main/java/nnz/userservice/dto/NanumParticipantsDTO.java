package nnz.userservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import nnz.userservice.entity.Nanum;

import java.time.LocalDate;
import java.util.List;

@NoArgsConstructor
@Getter
public class NanumParticipantsDTO {

    private String title;
    private String location;
    private LocalDate date;
    private List<ParticipantDTO> participants;

    public static NanumParticipantsDTO of(Nanum nanum, List<ParticipantDTO> participants) {
        NanumParticipantsDTO dto = new NanumParticipantsDTO();
        dto.title = nanum.getTitle();
        dto.location = nanum.getLocation();
        dto.date = nanum.getDate();
        dto.participants = participants;
        return dto;
    }


    @NoArgsConstructor
    @AllArgsConstructor
    @Builder
    @Getter
    public static class ParticipantDTO {
        private Long id;
        private String profileImage;
        private String nickname;
        private Boolean isFollower;
        private Boolean isReceived;
        private Boolean isCertificated;
    }
}
