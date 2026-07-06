import {BrowserRouter, Navigate, Route, Routes} from "react-router-dom";
import Navbar from "./components/Navbar";
import HomePage from "./pages/buyer/HomePage.jsx";
import ProductDetailPage from "./pages/buyer/ProductDetailPage.jsx";
import CartPage from "./pages/buyer/CartPage.jsx";
import Footer from "./components/Footer.jsx";
import LoginPage from './pages/buyer/LoginPage.jsx';
import RegisterPage from './pages/buyer/RegisterPage.jsx'; // 1. Import thêm trang Đăng ký
import SellerLayout from "./pages/seller/SellerLayout.jsx";
import SellerDashboardPage from "./pages/seller/SellerDashboardPage.jsx";
import SellerProductsPage from "./pages/seller/SellerProductsPage.jsx";
import SellerProductsCreatePage from "./pages/seller/SellerCreateProductPage.jsx";
import SellerProductsEditPage from "./pages/seller/SellerEditProductPage.jsx";
import SellerOrdersPage from "./pages/seller/SellerOrdersPage.jsx";
import SellerRevenuePage from "./pages/seller/SellerRevenuePage.jsx";
import TopSellingPage from "./pages/seller/SellerTopSellingPage.jsx";

import AdminLayout from "./pages/admin/AdminLayout.jsx";
import AdminDashboardPage from "./pages/admin/AdminDashboardPage.jsx";
import BuyerManagementPage from "./pages/admin/BuyerManagementPage.jsx";
import SellerManagementPage from "./pages/admin/SellerManagementPage.jsx";

function App() {
    return (
        <BrowserRouter>

            <Navbar/>

            <Routes>
                <Route path="/" element={<Navigate to="/login" replace/>}/>
                <Route path="/home" element={<HomePage/>}/>
                <Route path="/product" element={<ProductDetailPage/>}/>
                <Route path="/cart" element={<CartPage/>}/>

                <Route path="/login" element={<LoginPage/>}/>
                <Route path="/register" element={<RegisterPage/>}/>

                <Route
                    path="/product/:id"
                    element={<ProductDetailPage/>}
                />

                <Route path="/seller" element={<SellerLayout/>}>
                    {/* Tự động chuyển hướng từ /seller sang /seller/dashboard */}
                    <Route index element={<Navigate to="dashboard" replace/>}/>

                    <Route path="dashboard" element={<SellerDashboardPage/>}/>
                    <Route path="products" element={<SellerProductsPage/>}/>
                    <Route path="products/create" element={<SellerProductsCreatePage/>}/>
                    <Route path="products/edit/:id" element={<SellerProductsEditPage/>}/>
                    <Route path="orders" element={<SellerOrdersPage/>}/>
                    <Route path="revenue" element={<SellerRevenuePage/>}/>
                    <Route path="top-selling" element={<TopSellingPage/>}/>
                </Route>

                <Route path="/admin" element={<AdminLayout/>}>
                    <Route index element={<Navigate to="dashboard" replace/>}/>
                    <Route path="dashboard" element={<AdminDashboardPage/>}/>
                    <Route path="buyers" element={<BuyerManagementPage/>}/>
                    <Route path="sellers" element={<SellerManagementPage/>}/>
                </Route>
            </Routes>

            <Footer/>
        </BrowserRouter>
    );
}

export default App;