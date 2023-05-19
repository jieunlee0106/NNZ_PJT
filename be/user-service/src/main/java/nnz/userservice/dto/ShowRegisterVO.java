package nnz.userservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
public class ShowRegisterVO {

    String title;
    String path;
    Long createdBy;

    public void setRequester(Long requester) {
        this.createdBy = requester;
    }
}
