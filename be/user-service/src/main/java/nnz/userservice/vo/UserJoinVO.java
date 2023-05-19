package nnz.userservice.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class UserJoinVO {

    private String email;
    private String pwd;
    private String confirmPwd;
    private String nickname;
    private String phone;
}
