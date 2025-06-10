import React from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import Home from "./components/Home";
import MyNavbar from "./components/Navbar";
import Footer from "./components/Footer"; 

function App() {
  return (
    <div>
      <MyNavbar />
      <Home />
      <Footer /> 
    </div>
  );
}

export default App;
