function CartPage() {

    return (
        <div className="container mt-5">

            <h2 className="mb-4">
                Giỏ hàng của bạn
            </h2>

            <table className="table table-bordered">

                <thead>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                </tr>
                </thead>

                <tbody>
                <tr>
                    <td>Đèn ngủ mặt trăng</td>
                    <td>199.000 đ</td>
                    <td>1</td>
                    <td>199.000 đ</td>
                </tr>

                <tr>
                    <td>Gấu bông decor</td>
                    <td>149.000 đ</td>
                    <td>2</td>
                    <td>298.000 đ</td>
                </tr>
                </tbody>

            </table>

            <div className="text-end">

                <h4 className="text-danger">
                    Tổng cộng: 497.000 đ
                </h4>

                <button className="btn btn-success">
                    Tiến hành thanh toán
                </button>

            </div>

        </div>
    );
}

export default CartPage;