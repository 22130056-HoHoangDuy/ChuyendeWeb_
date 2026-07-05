import { BrowserRouter, Route, Routes, Navigate } from "react-router-dom";
import Navbar from "./components/Navbar";
import HomePage from "./pages/HomePage";
import ProductDetailPage from "./pages/ProductDetailPage";
import CartPage from "./pages/CartPage";
import Footer from "./components/Footer.jsx";
import LoginPage from './pages/LoginPage';
import RegisterPage from './pages/RegisterPage';
import ProfilePage from './pages/ProfilePage';

function App() {
    return (
        <BrowserRouter>

            <Navbar/>

            <Routes>
                <Route path="/" element={<Navigate to="/login" replace />} />
                <Route path="/home" element={<HomePage/>}/>
                <Route path="/product" element={<ProductDetailPage/>}/>
                <Route path="/cart" element={<CartPage/>}/>

                <Route path="/login" element={<LoginPage />} />
                <Route path="/register" element={<RegisterPage />} />
                <Route path="/profile" element={<ProfilePage />} />

                <Route
                    path="/product/:id"
                    element={<ProductDetailPage/>}
                />
            </Routes>

            <Footer/>
        </BrowserRouter>
    );
}

export default App;