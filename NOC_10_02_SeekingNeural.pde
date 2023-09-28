// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A Vehicle controlled by a Perceptron

Vehicle v; //forbereder klassen vehcile, kalder den via v

PVector desired;  //opretter en vektor, kaldt desired

ArrayList<PVector> targets; //opretter en arraylist med datatypen PVector, arralisten heder targets

void setup() {  //køre setup funktionen, som kun køre igennem en gang
  size(640, 360); //sætter displaystørrelsen til 640 * 360 pixels
  // The Vehicle's desired position
  desired = new PVector(width/2,height/2);  //sætter variablen desired til halvdelen af breden og halvdelen af højden

  
  // Create a list of targets
  makeTargets();  //Køre funktionen makeTargets
  
  // Create the Vehicle (it has to know about the number of targets
  // in order to configure its brain)
  v = new Vehicle(targets.size(), random(width), random(height)); //opretter et objekt af typen vehicle, med størelsen af targets og et tilfældigt tal fra 0 til breden og 0 til højden
}

// Make a random ArrayList of targets to steer towards
void makeTargets() { //funktionen makeTargets
  targets = new ArrayList<PVector>();  //opretter targets arraylisten med datatypen vektor
  for (int i = 0; i < 8; i++) { //for løkke, gentages 8 gange
    targets.add(new PVector(random(width), random(height))); //tilføjer en ny vektor til arraylisten med værdien mellem 0 og breden, og 0 og højden
  }
}

void draw() {  //draw løkke, gentages til programmet stoppes
  background(255);  //sætter bagrunden til hvid

  // Draw a circle to show the Vehicle's goal
  stroke(0); //sætter farven af linjer til sort
  strokeWeight(2); //sætter breden af linjer
  fill(0, 100);  //sætter fill farven af 2d figure
  ellipse(desired.x, desired.y, 36, 36); //laver en ellipse, som har midte i pvektoren desired og diameteren 36 pixels

  // Draw the targets
  for (PVector target : targets) { //for løkke, som gentager samme funktionen for alle punkt i et array
    noFill();  //sætter fill til ingenting
    stroke(0); //sætter linje farve til sort
    strokeWeight(2);  //sætter linje brede til 2
    ellipse(target.x, target.y, 16, 16);  //opretter en ellipse i vektorens punkt med diameter 16
    line(target.x,target.y-16,target.x,target.y+16);  //laver en streg over ellipsen
    line(target.x-16,target.y,target.x+16,target.y);  //laver en streg over ellipsen
  }
  
  // Update the Vehicle
  v.steer(targets);  //køre funktioen steer i klassen vehicle
  v.update();  //køre funktionen update i klassen vehicle
  v.display();  //køre funktionen display i klassen vehicle
}

void mousePressed() {//køre funktionen hvis musseknap bliver trykket
  makeTargets(); //funktionen makeTargets
}

