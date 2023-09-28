// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Simple Perceptron Example
// See: http://en.wikipedia.org/wiki/Perceptron

// Perceptron Class
class Perceptron {
  float[] weights;  // Array of weights for inputs
  float c;          // Learning constant

  // Perceptron is created with n weights and a learning constant
  Perceptron(int n, float c_) {
    weights = new float[n];
    c = c_;
    
    // Initialize weights with random values between 0 and 1
    for (int i = 0; i < weights.length; i++) {
      weights[i] = random(0, 1);
    }
  }

  // Function to train the Perceptron
  // Weights are adjusted based on the vehicle's error
  void train(PVector[] forces, PVector error) {
    for (int i = 0; i < weights.length; i++) {
      // Update weights using the learning constant, error, and forces
      weights[i] += c * error.x * forces[i].x;         
      weights[i] += c * error.y * forces[i].y;
      
      // Ensure weights are within the range of 0 to 1
      weights[i] = constrain(weights[i], 0, 1);
    }
  }

  // Give me a steering result
  PVector feedforward(PVector[] forces) {
    // Sum all weighted values
    PVector sum = new PVector();
    for (int i = 0; i < weights.length; i++) {
      forces[i].mult(weights[i]);
      sum.add(forces[i]);
    }
    return sum;
  }
}
