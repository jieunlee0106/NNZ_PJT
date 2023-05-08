package nnz.userservice.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
public class UserUpdateProfileVO {

    private String nickname;
    private String oldPwd;
    private String newPwd;
    private String confirmNewPwd;

}
