package com.ecommerce.product.repository;

import com.ecommerce.product.domain.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByCategoryId(Long categoryId);

    List<Product> findByIdIn(List<Long> ids);

    @Query("""
                SELECT p
                FROM Product p
                WHERE
                    (:keyword IS NULL OR
                        LOWER(p.productName)
                        LIKE LOWER(CONCAT('%', :keyword, '%')))
                AND
                    (:categoryId IS NULL
                        OR p.categoryId = :categoryId)
                AND
                    (:origin IS NULL
                        OR p.origin = :origin)
                AND
                    (:size IS NULL
                        OR p.size = :size)
            """)
    List<Product> filterProducts(
            @Param("keyword") String keyword,
            @Param("categoryId") Long categoryId,
            @Param("origin") String origin,
            @Param("size") String size
    );
}