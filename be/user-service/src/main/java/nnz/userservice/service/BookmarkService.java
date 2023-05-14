package nnz.userservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;

public interface BookmarkService {

    void wish(Long userId, Long nanumId);
    void cancelWish(Long userId, Long nanumId);
    void toggleWish(Long userId, Long nanumId) throws JsonProcessingException;
}
