// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Simple Perceptron Example
// See: http://en.wikipedia.org/wiki/Perceptron

// Perceptron Class

class Perceptron { 
  float[] weights;  // Array of weights for inputs
  float c;          // learning constant

  // Perceptron is created with n weights and learning constant
  Perceptron(int n, float c_) {  //konstructer, laver en perceptron ud fra størrelsen af targets og en læringskonstant
    weights = new float[n];  //laver en floatlist med størrelsen af targets
    c = c_; //sætter læringskonstanten for hele klassen til konstrukterens modtagede læringskonstant
    // Start with random weights
    for (int i = 0; i < weights.length; i++) {  //opretter en vægt til hver plads i floatlisten
      weights[i] = random(0, 1);
    }
  }

  // Function to train the Perceptron
  // Weights are adjusted based on vehicle's error
  void train(PVector[] forces, PVector error) {    //funktionen train
    for (int i = 0; i < weights.length; i++) {    //gentages størrelsen af weights gange
      weights[i] += c*error.x*forces[i].x;         //ganger læringskonstanten med vektoren errors x koordinat og ganger derefter med forces vektorens x koordinat
      weights[i] += c*error.y*forces[i].y;        //ganger læringskonstanten med vektoren errors y koordinat og ganger derefter med forces vektorens y koordinat
      weights[i] = constrain(weights[i], 0, 1);    //sætter en grænse for hvor stor float i weights kan være
    }
  }

  // Give me a steering result
  PVector feedforward(PVector[] forces) {  //funktionen feedforward, returner en pvector
    // Sum all values
    PVector sum = new PVector();  //opretter en lokal vektor kaldt sum
    for (int i = 0; i < weights.length; i++) {  //for løkke, gentages længden af weights gange
      forces[i].mult(weights[i]);  //ganger den i'te vektor i forces med den i'te vektor i weights
      sum.add(forces[i]);    //lægger værdien af vektoren ind i sum vektoren
    }
    return sum; //retunere vektoren sum
  }
}
