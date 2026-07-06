import { useEffect, useState } from "react";
import HeroBanner from "../../components/HeroBanner.jsx";
import ProductCard from "../../components/ProductCard.jsx";
import { getHomeProducts } from "../../services/productService.js";

function HomePage() {

    const [products, setProducts] = useState([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        loadProducts();
    }, []);

    const loadProducts = async () => {
        try {
            const data = await getHomeProducts();

            console.log("Products:", data);

            setProducts(data);
        } catch (error) {
            console.error("Lỗi lấy sản phẩm:", error);
        } finally {
            setLoading(false);
        }
    };

    return (
        <>
            <HeroBanner />

            <div className="container mt-5">

                <h2 className="mb-4">
                    Sản phẩm nổi bật
                </h2>

                {loading ? (
                    <h5>Đang tải sản phẩm...</h5>
                ) : (
                    <div className="row">
                        {products.map(product => (
                            <ProductCard
                                key={product.sellerProductId}
                                product={product}
                            />
                        ))}
                    </div>
                )}

            </div>
        </>
    );
}

export default HomePage;