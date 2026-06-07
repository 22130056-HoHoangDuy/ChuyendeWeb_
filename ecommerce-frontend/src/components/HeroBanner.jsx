import heroImage from "../assets/hero.png";

function HeroBanner() {
    return (
        <div
            className="text-white py-5"
            style={{
                backgroundColor: "#87CEEB",
                minHeight: "400px",
                display: "flex",
                alignItems: "center"
            }}
        >
            <div className="container text-center">

                <h1 className="display-4 fw-bold">
                    Trang trí phòng bé yêu
                </h1>

                <p className="lead mt-3">
                    Biến căn phòng thành thế giới cổ tích
                </p>

                <button className="btn btn-light btn-lg mt-3">
                    Khám phá ngay
                </button>

            </div>
        </div>
    );
}

export default HeroBanner;