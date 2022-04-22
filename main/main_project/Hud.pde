class Hud { // Affichage des coordonnées
  private PMatrix3D hud;
  Hud() {
     // Should be constructed just after P3D size() or fullScreen()
     this.hud = g.getMatrix((PMatrix3D) null);
  }

  private void begin() {
    g.noLights();
    g.pushMatrix();
    g.hint(PConstants.DISABLE_DEPTH_TEST);
    g.resetMatrix();
    g.applyMatrix(this.hud);
  }

  private void end() {
    g.hint(PConstants.ENABLE_DEPTH_TEST);
    g.popMatrix();
  }

  private void displayFPS() {
    // Bottom left area
    noStroke();
    fill(96);
    rectMode(CORNER);
    rect(10, height-30, 60, 20, 5, 5, 5, 5);
    // Value
    fill(0xF0);
    textMode(SHAPE);
    textSize(14);
    textAlign(CENTER, CENTER);
    text(String.valueOf((int)frameRate) + " fps", 40, height-20);
  }
  public void displayCamera(Camera camera){
    noStroke();
    fill(96);
    rectMode(CORNER);
    rect(25, 0, 200, 230, 5, 5, 5, 5); 
    fill(0xF0);
    textMode(SHAPE);
    textSize(14);
    textAlign(CENTER, CENTER);
    text("            Camera   ", 40, 20); // affiche les coordonnées de la caméra
    text("   Longitude   "+ String.valueOf((int)(camera.longitude*180/PI) + " °"),80, 50); // Coordonnées lors déplacement haut-bas
    text("    Colatitude  "+ String.valueOf((int)(camera.colatitude*180/PI) + " °"),80, 80); // Coordonnées lors déplacement gauche-droite
    text("   Radius   "+ String.valueOf((int)camera.radius) + " m",80, 110); // Zoom : + = le radius diminue et - = le radius augmente
    text("X " + String.valueOf((int)camera.y),80,140);
    text("Y " + String.valueOf((int)camera.z),80,170);
    text("Z " + String.valueOf((int)camera.x),80,200);
   

 }

  public void update(Camera camera) {
    this.begin();
    this.displayFPS(); // permet de mettre à jour la FrameRate lors de chaque déplacement
    this.displayCamera(camera); // permet de mettre à jour les coordonnées de la caméra
    this.end();
  }
}
