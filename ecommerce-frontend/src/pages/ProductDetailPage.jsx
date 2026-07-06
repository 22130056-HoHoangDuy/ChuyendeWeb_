import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { getProductDetail, addToCart } from "../services/productService";

function ProductDetailPage() {
    const { id } = useParams();
    const [product, setProduct] = useState(null);
    const [quantity, setQuantity] = useState(1);
    const [isAdding, setIsAdding] = useState(false);

    useEffect(() => {
        let isMounted = true;
        const loadProduct = async () => {
            try {
                const data = await getProductDetail(id);
                if (isMounted) setProduct(data);
            } catch (error) {
                console.error("Lỗi tải chi tiết:", error);
            }
        };
        loadProduct();
        return () => { isMounted = false; };
    }, [id]);

    const handleAddToCart = async () => {
        if (!product) return;
        setIsAdding(true);
        try {
            // userId nên được lấy từ Auth Context hoặc localStorage
            const userId = 1;
            await addToCart(userId, product.id, quantity);
            alert("Đã thêm vào giỏ hàng thành công!");
        } catch (error) {
            console.error("Lỗi:", error);
            alert("Có lỗi xảy ra khi thêm vào giỏ.");
        } finally {
            setIsAdding(false);
        }
    };

    if (!product) return <div className="container mt-5">Đang tải sản phẩm...</div>;

    return (
        <div className="container mt-5">
            <div className="row">
                <div className="col-md-6">
                    <img src={product.avatar || "https://via.placeholder.com/600x400"}
                         className="img-fluid rounded" alt={product.productName} />
                </div>
                <div className="col-md-6">
                    <h2>{product.productName}</h2>
                    <h3 className="text-danger">{product.price?.toLocaleString()} đ</h3>
                    <p className="mt-4">{product.description}</p>

                    {/* Input chọn số lượng */}
                    <div className="input-group" style={{ maxWidth: "150px" ,marginBottom:"10px"}}>
                        <button
                            className="btn btn-outline-secondary"
                            type="button"
                            onClick={() => setQuantity(prev => Math.max(1, prev - 1))}
                        >-</button>

                        <input
                            type="number"
                            className="form-control text-center"
                            value={quantity}
                            readOnly
                        />


                        <button
                            className="btn btn-outline-secondary"
                            type="button"
                            onClick={() => setQuantity(prev => Math.min(999, prev + 1))}
                        >+</button>
                    </div>

                    <div className="d-flex gap-3">
                        <button className="btn btn-primary" onClick={handleAddToCart} disabled={isAdding}>
                            {isAdding ? "Đang xử lý..." : "Thêm vào giỏ hàng"}
                        </button>
                    </div>
                </div>
            </div>
        </div>
    );
}

export default ProductDetailPage;