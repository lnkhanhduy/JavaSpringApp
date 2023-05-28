package tdt.edu.finalproject.repositories;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import tdt.edu.finalproject.models.Flower;

public interface FlowerRepository extends CrudRepository<Flower, Integer> {
    @Query(value = "select * from Flower f where f.id = ?1", nativeQuery = true)
    Iterable<Flower> findFlowerById(@Param("id") int id);

    @Query(value = "select * from Flower f where f.id = ?1", nativeQuery = true)
    Flower findFlowerByIdFlower(@Param("id") int id);

    @Query(value = "select * from Flower f where f.name LIKE %?1%", nativeQuery = true)
    Iterable<Flower> findAllFlowerByName(@Param("name") String name);

    @Query(value = "select * from Flower ORDER BY price ASC", nativeQuery = true)
    Iterable<Flower> FilterFlowerByPriceASC();

    @Query(value = "select * from Flower ORDER BY price DESC", nativeQuery = true)
    Iterable<Flower> FilterFlowerByPriceDESC();

    @Query(value = "select * from Flower ORDER BY name ASC", nativeQuery = true)
    Iterable<Flower> FilterFlowerByNameASC();

    @Query(value = "select * from Flower ORDER BY name DESC", nativeQuery = true)
    Iterable<Flower> FilterFlowerByNameDESC();

    @Query(value = "select * from Flower f where f.name LIKE %?1% ORDER BY name ASC", nativeQuery = true)
    Iterable<Flower> findByNameAndFilterFlowerByNameASC(@Param("name") String name);

    @Query(value = "select * from Flower f where f.name LIKE %?1% ORDER BY name DESC", nativeQuery = true)
    Iterable<Flower> findByNameAndFilterFlowerByNameDESC(@Param("name") String name);

    @Query(value = "select * from Flower f where f.name LIKE %?1% ORDER BY price ASC", nativeQuery = true)
    Iterable<Flower> findByNameAndFilterFlowerByPriceASC(@Param("name") String name);

    @Query(value = "select * from Flower f where f.name LIKE %?1% ORDER BY price DESC", nativeQuery = true)
    Iterable<Flower> findByNameAndFilterFlowerByPriceDESC(@Param("name") String name);

    @Modifying
    @Transactional
    @Query(value = "UPDATE Flower f SET f.name=?1, f.price=?2, f.description=?3, f.quantity=?4, f.category=?5 where f.id=?6", nativeQuery = true)
    void updateFlower(@Param("name") String name, @Param("price") int price, @Param("description") String description,
            @Param("quantity") int quantity, @Param("category") String category, @Param("id") int id);

    @Modifying
    @Transactional
    @Query(value = "UPDATE Flower f SET f.quantity=?1 where f.id=?2", nativeQuery = true)
    void updateQuantityFlower(@Param("quantity") int quantity, @Param("id") int id);

    @Query(value = "select * from Flower f where f.category = 'Hoa sinh nhật'", nativeQuery = true)
    Iterable<Flower> findByCategoryBirthday(@Param("category") String category);

    @Query(value = "select * from Flower f where f.category = 'Hoa chúc mừng'", nativeQuery = true)
    Iterable<Flower> findByCategoryCongrate(@Param("category") String category);

    @Query(value = "select * from Flower f where f.category = 'Hoa tình yêu'", nativeQuery = true)
    Iterable<Flower> findByCategoryLove(@Param("category") String category);

    @Query(value = "select * from Flower f where f.category = 'Hoa khai trương'", nativeQuery = true)
    Iterable<Flower> findByCategoryOpen(@Param("category") String category);

    @Query(value = "select * from Flower f where f.category = 'Hoa đám cưới'", nativeQuery = true)
    Iterable<Flower> findByCategoryWedding(@Param("category") String category);

    @Query(value = "select * from Flower f where f.category = 'Hoa ngoại nhập'", nativeQuery = true)
    Iterable<Flower> findByCategoryForeign(@Param("category") String category);
}
