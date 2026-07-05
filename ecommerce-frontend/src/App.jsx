import {BrowserRouter, Route, Routes} from "react-router-dom";

import Navbar from "./components/Navbar";
import HomePage from "./pages/HomePage";
import ProductDetailPage from "./pages/ProductDetailPage";
import CartPage from "./pages/CartPage";
import Footer from "./components/Footer.jsx";

function App() {
    return (
        <BrowserRouter>

            <Navbar/>

            <Routes>
                <Route path="/" element={<HomePage/>}/>
                <Route path="/product" element={<ProductDetailPage/>}/>
                <Route path="/cart" element={<CartPage/>}/>
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