package tdt.edu.finalproject.repositories;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import tdt.edu.finalproject.models.Cart;

public interface CartRepository extends CrudRepository<Cart, Integer> {
    Iterable<Cart> findCartByUsername(String username);

    Iterable<Cart> findCartByStatus(String status);

    Iterable<Cart> findCartByIdFlower(int idFlower);

    @Query(value = "select * from Cart c where c.id = ?1", nativeQuery = true)
    Iterable<Cart> findCartById(@Param("id") int id);

    @Query(value = "select * from Cart c where c.username = ?1 and c.status = 'Thêm vào giỏ'", nativeQuery = true)
    Iterable<Cart> findCartByUsernameOrder(@Param("username") String username);

    @Modifying
    @Transactional
    @Query(value = "UPDATE Cart c SET c.status = 'Đã đặt hàng' WHERE c.id = ?1", nativeQuery = true)
    void updateWaitingCart(@Param("id") int id);

    @Modifying
    @Transactional
    @Query(value = "UPDATE Cart c SET c.status = 'Đã huỷ' WHERE c.id = ?1", nativeQuery = true)
    void updateCancelCart(@Param("id") int id);
}
