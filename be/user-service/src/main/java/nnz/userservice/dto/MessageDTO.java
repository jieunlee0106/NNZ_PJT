package nnz.userservice.dto;

import lombok.*;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@ToString
public class MessageDTO {

    private String to;
    private String content;
}
