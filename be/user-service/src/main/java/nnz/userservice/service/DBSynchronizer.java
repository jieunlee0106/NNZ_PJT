package nnz.userservice.service;

public interface DBSynchronizer<T> {

    void create(T vo);
    void update(T vo);
    void delete(T vo);
}
