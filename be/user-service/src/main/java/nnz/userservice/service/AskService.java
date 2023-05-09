package nnz.userservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import nnz.userservice.dto.ShowRegisterVO;
import nnz.userservice.dto.UserReportVO;

public interface AskService {

    void askRegisterShow(ShowRegisterVO vo) throws JsonProcessingException;
    void reportUser(UserReportVO vo) throws JsonProcessingException;
}
