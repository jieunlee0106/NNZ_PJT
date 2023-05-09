package nnz.userservice.repository;

import nnz.userservice.entity.Nanum;
import nnz.userservice.entity.ReceiveNanum;
import nnz.userservice.entity.User;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ReceiveNanumRepository extends JpaRepository<ReceiveNanum, Long> {

    @Query("select rn.nanum from ReceiveNanum rn " +
            "where rn.receiver = :receiver")
    List<Nanum> findNanumByReceiver(@Param("receiver") User receiver);

    @Query(value = "select rn.nanum from ReceiveNanum rn " +
            "where rn.receiver = :receiver",
            countQuery = "select count(rn.nanum) from ReceiveNanum rn " +
                    "where rn.receiver = :receiver")
    Page<Nanum> findNanumByReceiver(@Param("receiver") User receiver, Pageable pageable);

    @EntityGraph(attributePaths = {"receiver"})
    List<ReceiveNanum> findByNanum(Nanum nanum);

    Integer countByReceiver(User receiver);
}
