package tdt.edu.finalproject.repositories;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import tdt.edu.finalproject.models.Account;

public interface AccountRepository extends CrudRepository<Account, String> {

    @Query(value = "select * from Account a where a.username = ?1", nativeQuery = true)
    Account findAccountByUsername(String username);

    @Query(value = "select * from Account a where a.email = ?1", nativeQuery = true)
    Account findAccountByEmail(String email);

    @Modifying
    @Transactional
    @Query(value = "DELETE FROM Account WHERE username = ?1", nativeQuery = true)
    void deleteByUsername(@Param("username") String username);

    @Modifying
    @Transactional
    @Query(value = "UPDATE Account a SET a.password = ?1 WHERE a.username = ?2", nativeQuery = true)
    void updatePasswordAccount(@Param("password") String password, @Param("username") String username);

    @Modifying
    @Transactional
    @Query(value = "UPDATE Account a SET a.fullname = ?1, a.email = ?2 WHERE a.username = ?3", nativeQuery = true)
    void updateAccount(@Param("fullname") String fullname, @Param("email") String email, @Param("username") String username);
}
