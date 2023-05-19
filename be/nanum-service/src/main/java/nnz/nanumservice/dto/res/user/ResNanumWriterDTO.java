package nnz.nanumservice.dto.res.user;

import lombok.Getter;
import nnz.nanumservice.entity.User;

@Getter
public class ResNanumWriterDTO {

    private Long id;

    private String nickname;

    private String profileImage;

    private Boolean isFollow;

    private Boolean isTwitterFollow;

    public void setWriterInfo(User writer) {
        this.id = writer.getId();
        this.nickname = writer.getNickname();
        this.profileImage = writer.getProfileImage();
    }

    public void setIsFollow(boolean isFollow) {
        this.isFollow = isFollow;
    }
}
