package tdt.edu.finalproject.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import tdt.edu.finalproject.models.OrderF;

public interface OrderRepository extends CrudRepository<OrderF, Integer> {
    @Query(value = "select * from Orderflower of where of.username = ?1 GROUP BY of.idOrder ORDER BY of.id DESC  ", nativeQuery = true)
    Iterable<OrderF> findAllOrderByUsername(@Param("username") String username);

    @Query(value = "select * from Orderflower of GROUP BY of.idOrder ORDER BY of.id DESC;", nativeQuery = true)
    Iterable<OrderF> findAllOrderGroupById();

    @Query(value = "select * from Orderflower of where of.idOrder = ?1", nativeQuery = true)
    List<OrderF> findOrderByIdOrder(@Param("idOrder") String idOrder);

    @Query(value = "select * from Orderflower of GROUP BY of.idOrder ORDER BY of.id DESC", nativeQuery = true)
    List<OrderF> findAllOrder();

    @Query(value = "select * from Orderflower of where of.status = 'Thành công' GROUP BY of.idOrder ORDER BY of.id DESC", nativeQuery = true)
    List<OrderF> findAllOrderBySuccess();

    @Query(value = "select * from Orderflower of where of.status = 'Đang giao hàng' GROUP BY of.idOrder ORDER BY of.id DESC", nativeQuery = true)
    List<OrderF> findAllOrderByDelivery();

    @Query(value = "select * from Orderflower of where of.status = 'Chờ xác nhận' GROUP BY of.idOrder ORDER BY of.id DESC", nativeQuery = true)
    List<OrderF> findAllOrderByWaiting();

    @Query(value = "select * from Orderflower of where of.status = 'Đã huỷ' GROUP BY of.idOrder ORDER BY of.id DESC", nativeQuery = true)
    List<OrderF> findAllOrderByDeny();

    @Modifying
    @Transactional
    @Query(value = "UPDATE Orderflower of SET of.status = 'Đang giao hàng' WHERE of.idOrder = ?1", nativeQuery = true)
    void updateDeliveryOrder(@Param("idOrder") String idOrder);

    @Modifying
    @Transactional
    @Query(value = "UPDATE Orderflower of SET of.status = 'Thành công' WHERE of.idOrder = ?1", nativeQuery = true)
    void updateSuccessOrder(@Param("idOrder") String idOrder);

    @Modifying
    @Transactional
    @Query(value = "UPDATE Orderflower of SET of.status = 'Đã huỷ' WHERE of.idOrder = ?1", nativeQuery = true)
    void updateDenyOrder(@Param("idOrder") String idOrder);

    @Modifying
    @Transactional
    @Query(value = "UPDATE Orderflower of SET of.timeResponse = ?1 WHERE of.idOrder = ?2", nativeQuery = true)
    void updateTimeResponserder(@Param("timeResponse") String timeResponse, @Param("idOrder") String idOrder);
}
