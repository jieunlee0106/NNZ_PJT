package nnz.userservice.service;

public interface BookmarkService {

    void wish(Long userId, Long nanumId);
    void cancelWish(Long userId, Long nanumId);
    void toggleWish(Long userId, Long nanumId);
}
