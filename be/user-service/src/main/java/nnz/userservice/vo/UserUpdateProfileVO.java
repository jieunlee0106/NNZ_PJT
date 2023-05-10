package nnz.userservice.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.Base64;

@NoArgsConstructor
@Getter
public class UserUpdateProfileVO {

    private String nickname;
    private String oldPwd;
    private String newPwd;
    private String confirmNewPwd;

    public void decodeNickname() {
        this.nickname = new String(Base64.getDecoder().decode(nickname));
    }
}
