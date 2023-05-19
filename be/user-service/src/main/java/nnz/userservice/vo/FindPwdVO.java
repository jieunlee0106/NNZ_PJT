package nnz.userservice.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class FindPwdVO {

    private String phone;
    private String pwd;
    private String confirmPwd;
}
