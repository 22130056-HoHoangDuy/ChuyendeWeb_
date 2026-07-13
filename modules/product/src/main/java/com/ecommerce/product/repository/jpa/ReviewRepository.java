package com.ecommerce.product.repository.jpa;

import com.ecommerce.product.domain.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    boolean existsByOrderItemId(Long orderItemId);

    @Query(value = "SELECT COUNT(*) FROM return_request WHERE order_item_id = :orderItemId", nativeQuery = true)
    int countReturnRequestByOrderItemId(@Param("orderItemId") Long orderItemId);

//    @Query(value = """
//    SELECT COUNT(o.id) FROM orders o
//    JOIN order_item oi ON o.id = oi.order_id
//    WHERE oi.id = :orderItemId
//    AND o.order_status = 'DELIVERED'
//""", nativeQuery = true)
//    int countDeliveredOrderItems(@Param("orderItemId") Long orderItemId);
@Query(value = """
    SELECT COUNT(o.id) FROM orders o 
    JOIN order_items oi ON o.id = oi.order_id 
    WHERE oi.id = :orderItemId 
    AND o.order_status = 'DELIVERED'
""", nativeQuery = true)
int countDeliveredOrderItems(@Param("orderItemId") Long orderItemId);

    List<Review> findAllByProductId(Long productId);

    List<Review> findAllByUserIdOrderByCreatedAtDesc(Long userId);
}