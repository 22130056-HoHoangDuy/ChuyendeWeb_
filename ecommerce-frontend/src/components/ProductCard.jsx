import { Link } from "react-router-dom";

function ProductCard({ product }) {

    const imageUrl =
        product.avatar ||
        "https://placehold.co/300x220?text=No+Image";

    return (
        <div className="col-md-3 mb-4">

            <div className="card h-100 shadow-sm">

                <Link to={`/product/${product.sellerProductId}`}>

                    <img
                        src={imageUrl}
                        className="card-img-top"
                        alt={product.productName}
                        style={{
                            height: "220px",
                            objectFit: "cover"
                        }}
                    />

                </Link>

                <div className="card-body d-flex flex-column">

                    <h5>
                        {product.productName}
                    </h5>

                    <p className="text-warning">
                        ⭐ {product.averageRating}
                    </p>

                    <p className="text-danger fw-bold">
                        {product.price.toLocaleString()} đ
                    </p>

                    <Link
                        to={`/product/${product.sellerProductId}`}
                        className="btn btn-primary w-100"
                    >
                        Xem chi tiết
                    </Link>

                </div>

            </div>

        </div>
    );
}

export default ProductCard;