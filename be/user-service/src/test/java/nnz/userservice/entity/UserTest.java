package nnz.userservice.entity;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;

import static org.junit.jupiter.api.Assertions.*;

@DataJpaTest
@AutoConfigureTestDatabase
@Transactional
class UserTest {

    @Autowired
    private EntityManager em;

    @Test
    public void test() {
        User user = new User();
        em.persist(user);

        System.out.println("user = " + user);
        System.out.println("user.getCreateAt() = " + user.getCreatedAt());
        System.out.println("user.getUpdatedAy() = " + user.getUpdatedAt());
    }

}