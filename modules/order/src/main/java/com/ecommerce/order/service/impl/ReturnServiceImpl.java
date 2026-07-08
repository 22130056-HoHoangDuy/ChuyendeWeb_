package com.ecommerce.order.service.impl;

import com.ecommerce.order.domain.Order;
import com.ecommerce.order.domain.OrderItem;
import com.ecommerce.order.domain.ReturnRefund;
import com.ecommerce.order.domain.ReturnRequest;
import com.ecommerce.order.enums.OrderStatus;
import com.ecommerce.order.enums.RefundStatus;
import com.ecommerce.order.enums.ReturnStatus;
import com.ecommerce.order.repository.OrderItemRepository;
import com.ecommerce.order.repository.OrderRepository;
import com.ecommerce.order.repository.ReturnRefundRepository;
import com.ecommerce.order.repository.ReturnRequestRepository;
import com.ecommerce.order.service.ReturnService;
import com.ecommerce.product.domain.SellerProduct;
import com.ecommerce.product.repository.SellerProductRepository;
import com.ecommerce.user.service.WalletService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReturnServiceImpl implements ReturnService {

    private final ReturnRequestRepository returnRepository;
    private final OrderItemRepository orderItemRepository;
    private final ReturnRefundRepository refundRepository;
    private final WalletService walletService;
    private final SellerProductRepository sellerProductRepository;
    private final OrderRepository orderRepository;

    @Override
    @Transactional
    public ReturnRequest createReturnRequest(
            Long buyerId,
            Long orderItemId,
            String reason,
            String evidence) {

        OrderItem item = orderItemRepository.findById(orderItemId)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Không tìm thấy món hàng trong đơn hàng"));
        Order order = orderRepository.findById(item.getOrderId())
                .orElseThrow(() ->
                        new RuntimeException(
                                "Không tìm thấy đơn hàng"));

        if (!order.getUserId().equals(buyerId)) {
            throw new RuntimeException(
                    "Bạn không có quyền gửi khiếu nại cho đơn hàng này");
        }

        if (returnRepository.existsByOrderItemId(orderItemId)) {
            throw new RuntimeException(
                    "Sản phẩm này đã được gửi yêu cầu khiếu nại trước đó!");
        }
        // Không cho trả hàng
        if (order.getOrderStatus() != OrderStatus.DELIVERED) {
            throw new RuntimeException(
                    "Chỉ được khiếu nại đơn hàng đã giao thành công");
        }

        SellerProduct sellerProduct =
                sellerProductRepository
                        .findById(item.getSellerProductId())
                        .orElseThrow(() ->
                                new RuntimeException("Không tìm thấy sản phẩm"));

        // Nhập hàng về kho
        sellerProduct.setStock(
                sellerProduct.getStock()
                        + item.getQuantity()
        );

        sellerProductRepository.save(sellerProduct);

        ReturnRequest request = ReturnRequest.builder()
                .orderItemId(orderItemId)
                .customerId(buyerId)
                .sellerId(sellerProduct.getSellerId())
                .returnReason(reason)
                .evidenceImageUrls(evidence)
                .status(ReturnStatus.PENDING)
                .createdAt(LocalDateTime.now())
                .updatedAt(LocalDateTime.now())
                .build();

        return returnRepository.save(request);
    }

    @Override
    @Transactional
    public void approveAndRefund(Long requestId) {

        ReturnRequest request = returnRepository.findById(requestId)
                .orElseThrow(() ->
                        new RuntimeException(
                                "Yêu cầu khiếu nại không tồn tại"));

        if (request.getStatus() != ReturnStatus.PENDING) {
            throw new RuntimeException(
                    "Yêu cầu này đã được xử lý rồi!");
        }

        OrderItem item =
                orderItemRepository
                        .findById(request.getOrderItemId())
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Dữ liệu món hàng không khớp"));

        SellerProduct sellerProduct =
                sellerProductRepository
                        .findById(item.getSellerProductId())
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Không tìm thấy sản phẩm"));

        double refundAmount =
                item.getPrice() * item.getQuantity();

        // trừ tiền người bán
        walletService.changeBalance(
                sellerProduct.getSellerId(),
                -refundAmount);

        // hoàn tiền khách
        walletService.changeBalance(
                request.getCustomerId(),
                refundAmount);

        ReturnRefund refund =
                ReturnRefund.builder()
                        .returnRequestId(requestId)
                        .refundAmount(refundAmount)
                        .status(RefundStatus.COMPLETED)
                        .requestDate(LocalDateTime.now())
                        .build();

        refundRepository.save(refund);

        request.setStatus(ReturnStatus.APPROVED);
        request.setUpdatedAt(LocalDateTime.now());

        returnRepository.save(request);
    }

    @Override
    @Transactional
    public void rejectRequest(
            Long requestId,
            String adminNote) {

        ReturnRequest request =
                returnRepository
                        .findById(requestId)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Yêu cầu không tồn tại"));

        request.setStatus(ReturnStatus.REJECTED);
        request.setNote(adminNote);
        request.setUpdatedAt(LocalDateTime.now());

        returnRepository.save(request);
    }

    @Override
    public List<ReturnRequest> getAllRequests() {
        return returnRepository.findAll();
    }

    @Override
    public List<ReturnRequest> getRequestsByCustomerId(
            Long userId) {

        return returnRepository.findAllByCustomerId(userId);
    }
}