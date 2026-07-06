import {BrowserRouter, Route, Routes, Navigate, Outlet} from "react-router-dom";
import Navbar from "./components/Navbar";
import HomePage from "./pages/HomePage";
import ProductDetailPage from "./pages/ProductDetailPage";
import CartPage from "./pages/CartPage";
import Footer from "./components/Footer.jsx";
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';
import ProfilePage from './pages/ProfilePage';
const ProtectedRoute = ({ children }) => {
    const token = localStorage.getItem("accessToken");
    return token ? children : <Navigate to="/login" replace />;
};
const MainLayout = () => {
    return (
        <div style={{ display: 'flex', flexDirection: 'column', minHeight: '100vh' }}>
            <Navbar />
            <main style={{ flex: 1 }}> {/* flex: 1 giúp phần này đẩy Footer xuống dưới */}
                <Outlet />
            </main>
            <Footer />
        </div>
    );
};
function App() {
    return (
        <BrowserRouter>
            <Routes>
                {/* Nhóm Auth: Không có Navbar/Footer */}
                <Route path="/login" element={<LoginPage />} />
                <Route path="/register" element={<RegisterPage />} />

                {/* Nhóm chính: Có Navbar/Footer */}
                <Route element={<MainLayout />}>
                    <Route path="/" element={<Navigate to="/home" replace />} />
                    <Route path="/home" element={<HomePage />} />

                    {/* Nhóm Product */}
                    <Route path="product">
                        <Route index element={<ProductDetailPage />} />
                        <Route path=":id" element={<ProductDetailPage />} />
                    </Route>

                    <Route path="/cart" element={<CartPage />} />

                    {/* Route cần bảo vệ */}
                    <Route path="/profile" element={
                        <ProtectedRoute>
                            <ProfilePage />
                        </ProtectedRoute>
                    } />
                </Route>
            </Routes>
        </BrowserRouter>
    );
}

export default App;