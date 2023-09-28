// Seek
// Daniel Shiffman <http://www.shiffman.net>

// The "Vehicle" class
class Vehicle {
  
  // Vehicle now has a brain!
  Perceptron brain;
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed

  Vehicle(int n, float x, float y) {
    brain = new Perceptron(n, 0.001); // Create a Perceptron with 'n' inputs and a learning constant of 0.001
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    position = new PVector(x, y);
    r = 3.0; // Radius of the vehicle
    maxspeed = 4; // Maximum speed of the vehicle
    maxforce = 0.1; // Maximum steering force applied to the vehicle
  }

  // Method to update the position and behavior of the vehicle
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed to the maximum speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset acceleration to zero each cycle
    acceleration.mult(0);
    
    // Constrain the position of the vehicle within the canvas boundaries
    position.x = constrain(position.x, 0, width);
    position.y = constrain(position.y, 0, height);
  }

  // Method to apply a force to the vehicle
  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }
  
  // Method where the vehicle's brain processes information and determines steering
  void steer(ArrayList<PVector> targets) {
    // Make an array of forces
    PVector[] forces = new PVector[targets.size()];
    
    // Steer towards all targets
    for (int i = 0; i < forces.length; i++) {
      forces[i] = seek(targets.get(i)); // Calculate steering force for seeking each target
    }
    
    // The array of forces is used as input to the brain
    PVector result = brain.feedforward(forces);
    
    // Use the result to steer the vehicle
    applyForce(result);
    
    // Train the brain according to the error
    PVector error = PVector.sub(desired, position); // Calculate the error between the desired position and current position
    brain.train(forces, error); // Train the brain using forces and the error
  }
  
  // Method that calculates a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position); // A vector pointing from the position to the target
    
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    
    // Steering = Desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce); // Limit to maximum steering force
    
    return steer;
  }
    
  // Method to display the vehicle
  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + PI/2;
    fill(175);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    popMatrix();
  }
}
