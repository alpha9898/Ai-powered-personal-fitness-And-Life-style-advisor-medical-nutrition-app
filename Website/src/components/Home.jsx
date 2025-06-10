import React from "react";
import { Container, Button } from "react-bootstrap";
import { motion } from "framer-motion";
import "./Home.css";

const Home = () => {
  return (
    <>
      {/* Hero Section */}
      <div className="hero-section">
        <Container className="text-center text-white d-flex flex-column align-items-start justify-content-center h-100">
          <h5>#1 nutrition tracking app</h5>
          <h1 className="display-3 fw-bold">
            Nutrition tracking <br />
            for <span className="highlight">real life</span>
          </h1>
          <p className="lead">
            Make progress with the all-in-one food, exercise, and calorie tracker.
          </p>
          <Button className="cta-btn">START TODAY →</Button>
        </Container>
        <div className="phone-image">
          <img src="/Home2.jpg" alt="App Screenshot" />
        </div>
      </div>

      {/* Section 1 */}
      <section className="feature-section bg-white">
        <Container>
          <motion.div
            className="row align-items-center"
            initial={{ opacity: 0, x: -100 }}
            whileInView={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.8 }}
            viewport={{ once: true }}
          >
            <div className="col-md-6">
              <h2>Track Your Meals</h2>
              <p>
                Stay on top of your nutrition by logging every meal. Get detailed insights and make healthier choices.
              </p>
            </div>
            <div className="col-md-6">
              <motion.img
                src="/Home2.jpg"
                alt="Track Meals"
                className="feature-image"
                initial={{ opacity: 0, scale: 0.9 }}
                whileInView={{ opacity: 1, scale: 1 }}
                transition={{ duration: 0.6 }}
                viewport={{ once: true }}
              />
            </div>
          </motion.div>
        </Container>
      </section>

      {/* Section 2 */}
      <section className="feature-section bg-light">
        <Container>
          <motion.div
            className="row align-items-center flex-md-row-reverse"
            initial={{ opacity: 0, x: 100 }}
            whileInView={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.8 }}
            viewport={{ once: true }}
          >
            <div className="col-md-6">
              <h2>Monitor Your Exercise</h2>
              <p>
                Track your workouts, steps, and calories burned. Keep your body moving and stay motivated every day.
              </p>
            </div>
            <div className="col-md-6">
              <motion.img
                src="/Home2.jpg"
                alt="Track Exercise"
                className="feature-image"
                initial={{ opacity: 0, scale: 0.9 }}
                whileInView={{ opacity: 1, scale: 1 }}
                transition={{ duration: 0.6 }}
                viewport={{ once: true }}
              />
            </div>
          </motion.div>
        </Container>
      </section>

      {/* Section 3 */}
      <section className="feature-section bg-white">
        <Container>
          <motion.div
            className="row align-items-center"
            initial={{ opacity: 0, x: -100 }}
            whileInView={{ opacity: 1, x: 0 }}
            transition={{ duration: 0.8 }}
            viewport={{ once: true }}
          >
            <div className="col-md-6">
              <h2>Analyze Your Progress</h2>
              <p>
                Visualize your progress with powerful charts and data. Stay accountable and crush your goals.
              </p>
            </div>
            <div className="col-md-6">
              <motion.img
                src="/Home2.jpg"
                alt="Track Progress"
                className="feature-image"
                initial={{ opacity: 0, scale: 0.9 }}
                whileInView={{ opacity: 1, scale: 1 }}
                transition={{ duration: 0.6 }}
                viewport={{ once: true }}
              />
            </div>
          </motion.div>
        </Container>
      </section>

      {/* --- Extra Sections Below --- */}

      <section className="content-section bg-light text-dark">
        <Container>
          <motion.div
            initial={{ opacity: 0 }}
            whileInView={{ opacity: 1 }}
            transition={{ duration: 0.7 }}
            viewport={{ once: true }}
          >
            <h2>About Us</h2>
            <p>
              We help people live healthier lives through personalized nutrition tracking and insights.
            </p>
          </motion.div>
        </Container>
      </section>

      <section className="content-section bg-white text-dark">
        <Container>
          <motion.div
            initial={{ opacity: 0 }}
            whileInView={{ opacity: 1 }}
            transition={{ duration: 0.7 }}
            viewport={{ once: true }}
          >
            <h2>Features</h2>
            <p>
              Track your meals, calories, exercise, and more with our all-in-one platform.
            </p>
          </motion.div>
        </Container>
      </section>

      <section className="content-section bg-light text-dark">
        <Container>
          <motion.div
            initial={{ opacity: 0 }}
            whileInView={{ opacity: 1 }}
            transition={{ duration: 0.7 }}
            viewport={{ once: true }}
          >
            <h2>Why Choose Us</h2>
            <p>
              Our app is used by millions of users worldwide to stay healthy and fit.
            </p>
          </motion.div>
        </Container>
      </section>

      <section className="content-section bg-white text-dark" id="contact">
        <Container>
          <motion.div
            initial={{ opacity: 0 }}
            whileInView={{ opacity: 1 }}
            transition={{ duration: 0.7 }}
            viewport={{ once: true }}
          >
            <h2>Contact</h2>
            <p>Get in touch with us to learn more or ask any questions.</p>
          </motion.div>
        </Container>
      </section>
    </>
  );
};

export default Home;
