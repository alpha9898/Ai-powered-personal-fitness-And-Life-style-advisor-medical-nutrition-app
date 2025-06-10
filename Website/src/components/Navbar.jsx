import React from "react";
import { Navbar, Container, Nav } from "react-bootstrap";
import { Link as ScrollLink } from "react-scroll";
import "./Navbar.css";

const MyNavbar = () => {
  return (
    <Navbar expand="lg" className="custom-navbar fixed-top">
      <Container>
        <Navbar.Brand href="#">O+ Fitness</Navbar.Brand>
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="ms-auto">
            <ScrollLink
              to="home"
              spy={true}
              smooth={true}
              offset={-70}
              duration={500}
              className="nav-link"
              activeClass="active"
            >
              Home
            </ScrollLink>
            <ScrollLink
              to="features"
              spy={true}
              smooth={true}
              offset={-70}
              duration={500}
              className="nav-link"
              activeClass="active"
            >
              Features
            </ScrollLink>
            <ScrollLink
              to="contact"
              spy={true}
              smooth={true}
              offset={-70}
              duration={500}
              className="nav-link"
              activeClass="active"
            >
              Contact
            </ScrollLink>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
};

export default MyNavbar;
