package nnz.nanumservice.repository;

import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.User;
import nnz.nanumservice.entity.UserNanum;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserNanumRepository extends JpaRepository<UserNanum, Long> {

    List<UserNanum> findAllByNanum(Nanum nanum);

    Optional<UserNanum> findByNanumAndReceiver(Nanum nanum, User user);

    int countByNanumAndIsCertificated(Nanum nanum, boolean b);
}
