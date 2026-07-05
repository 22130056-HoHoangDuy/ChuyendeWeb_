package com.ecommerce.product.repository;

import com.ecommerce.product.domain.Review;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository
        extends JpaRepository<Review, Long> {

    @Query("""
            SELECT r.productId,
                   AVG(r.rating)
            FROM Review r
            WHERE r.productId IN :productIds
            GROUP BY r.productId
            """)
    List<Object[]> getAverageRatings(
            @Param("productIds")
            List<Long> productIds);

    @Query(value = """
            SELECT COUNT(*)
            FROM orders o
            JOIN order_items oi
                 ON o.id = oi.order_id
            WHERE oi.id = :orderItemId
            AND o.order_status = 'DELIVERED'
            """,
            nativeQuery = true)
    int countDeliveredOrderItems(
            @Param("orderItemId")
            Long orderItemId);

    List<Review> findAllByProductId(
            Long productId);

    List<Review> findAllByProductIdIn(
            List<Long> productIds);
}