import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import { Link } from "react-router-dom";
import { getProductDetail } from "../../services/productService.js";

function ProductDetailPage() {

    const { id } = useParams();

    const [product, setProduct] = useState(null);

    useEffect(() => {

        loadProduct();

    }, [id]);

    const loadProduct = async () => {

        try {

            const response =
                await getProductDetail(id);

            setProduct(response.data);

        } catch (error) {

            console.error(
                "Lỗi tải chi tiết sản phẩm",
                error
            );
        }
    };

    if (!product) {

        return (
            <div className="container mt-5">
                Đang tải...
            </div>
        );
    }

    return (
        <div className="container mt-5">

            <div className="row">

                <div className="col-md-6">

                    <img
                        src={
                            product.avatar ||
                            "https://via.placeholder.com/600x400?text=No+Image"
                        }
                    />

                </div>

                <div className="col-md-6">

                    <h2>
                        {product.productName}
                    </h2>

                    <h3 className="text-danger mt-3">
                        {product.price?.toLocaleString()} đ
                    </h3>

                    <p className="mt-4">
                        {product.description || "Chưa có mô tả sản phẩm"}
                    </p>

                    <p>
                        <strong>Tồn kho:</strong>{" "}
                        {product.stock}
                    </p>

                    <p>
                        <strong>SKU:</strong>{" "}
                        {product.sku}
                    </p>

                    <div className="d-flex gap-3 mt-4">

                        <Link
                            to="/cart"
                            className="btn btn-primary"
                        >
                            Thêm vào giỏ hàng
                        </Link>

                        <button
                            className="btn btn-outline-secondary"
                        >
                            Mua ngay
                        </button>

                    </div>

                </div>

            </div>

        </div>
    );
}

export default ProductDetailPage;