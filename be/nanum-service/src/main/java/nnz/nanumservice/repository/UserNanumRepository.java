package nnz.nanumservice.repository;

import nnz.nanumservice.entity.Nanum;
import nnz.nanumservice.entity.User;
import nnz.nanumservice.entity.UserNanum;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserNanumRepository extends JpaRepository<UserNanum, Long> {

    Optional<UserNanum> findByReceiver(User receiver);

    List<UserNanum> findAllByNanumAndIsCertificatedTrue(Nanum nanum);

    List<UserNanum> findAllByNanum(Nanum nanum);
}
