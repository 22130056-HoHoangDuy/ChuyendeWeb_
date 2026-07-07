import {useEffect, useState} from "react";
import {useParams} from "react-router-dom";
import {addToCart, getProductDetail} from "../services/productService";

// Hàm bổ trợ để lấy userId từ localStorage một cách an toàn
const getUserId = () => {
    try {
        const userStr = localStorage.getItem("user");
        return userStr ? JSON.parse(userStr).id : null;
    } catch (error) {
        console.error("Lỗi parse user từ localStorage:", error);
        return null;
    }
};

function ProductDetailPage() {
    const {id} = useParams();
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
        return () => {
            isMounted = false;
        };
    }, [id]);

    const handleAddToCart = async () => {
        if (!product) return;

        // FIX LỖI 1: Lấy userId động từ localStorage thay vì hard-code số 1
        const userId = getUserId();
        if (!userId) {
            alert("Vui lòng đăng nhập để thực hiện chức năng này!");
            return;
        }

        setIsAdding(true);
        try {
            // FIX LỖI 2: Đổi từ product.id sang product.sellerProductId theo yêu cầu của Backend
            await addToCart(userId, product.sellerProductId, quantity);
            alert("Đã thêm vào giỏ hàng thành công!");
        } catch (error) {
            console.error("Lỗi thêm vào giỏ hàng:", error);
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
                    <img
                        src={product.avatar || "https://via.placeholder.com/600x400"}
                        className="img-fluid rounded"
                        alt={product.productName}
                        // Thêm dòng này để "bọc lót" khi ảnh bị lỗi:
                        onError={(e) => {
                            e.target.onerror = null; // Tránh vòng lặp vô hạn nếu ảnh placeholder cũng lỗi
                            e.target.src = "https://via.placeholder.com/600x400";
                        }}
                    />
                </div>
                <div className="col-md-6">
                    <h2>{product.productName}</h2>
                    <h3 className="text-danger">{product.price?.toLocaleString()} đ</h3>
                    <p className="mt-4">{product.description}</p>

                    {/* Input chọn số lượng */}
                    <div className="input-group" style={{maxWidth: "150px", marginBottom: "10px"}}>
                        <button
                            className="btn btn-outline-secondary"
                            type="button"
                            onClick={() => setQuantity(prev => Math.max(1, prev - 1))}
                        >-
                        </button>

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
                        >+
                        </button>
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