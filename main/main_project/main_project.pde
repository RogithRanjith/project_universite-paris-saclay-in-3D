WorkSpace workspace;
Hud hud; // Affichage les coordonnees position
Camera camera;
Map3D map; // donné par le prof
Land land;
Gpx gpx; // Tracé GPS
Railways railways;
Roads roads;
//Buildings buildings;


void setup() {
  // Display setup
  fullScreen(P3D);
  // Setup Head Up Display
  this.hud = new Hud();
  smooth(8);
  frameRate(120);
  // Initial drawing
  background(0x40);
  
  hint(ENABLE_KEY_REPEAT); // répétition des touches pour faciliter les mouvements
  
  // Prepare local coordinate system grid & gizmo
  this.workspace = new WorkSpace(250*100);
  
  this.camera = new Camera();
 
   //Load Height Map 
   this.map = new Map3D("paris_saclay.data");
   this.land = new Land(this.map, "paris_saclay.jpg");
   this.gpx = new Gpx (this.map, "trail.geojson");
   this.railways = new Railways(this.map, "railways.geojson");
   this.roads = new Roads(this.map, "roads.geojson");
   
  /* 
   this.buildings = new Buildings(this.map);
   this.buildings.add("buildings_city.geojson", 0xFFaaaaaa);
   this.buildings.add("buildings_IPP.geojson", 0xFFCB9837);
   this.buildings.add("buildings_EDF_Danone.geojson", 0xFF3030FF);
   this.buildings.add("buildings_CEA_algorithmes.geojson", 0xFF30FF30);
   this.buildings.add("buildings_Thales.geojson", 0xFFFF3030);
   this.buildings.add("buildings_Paris_Saclay.geojson", 0xFFee00dd);
*/
}

void draw(){ //affiche tout la map
  background(0x40);
  this.workspace.update();
  this.camera.update();
  this.land.update();
  this.hud.update(this.camera); // pour annuler les réglages d'éclairages
  this.gpx.update();
  this.roads.update();
  this.railways.update();
  //this.buildings.update();
}

void keyPressed() {
  if (key == CODED){
    switch(keyCode){ // déplacement avec les flèches pour un droitier
      case LEFT:
        this.camera.adjustColatitude(-PI/100); // Déplacement gauche
        break;
      case RIGHT:
        this.camera.adjustColatitude(PI/100); // Déplacement droite
        break;
      case UP:
        this.camera.adjustLongitude(-PI/100); // Déplacement haut
        break;
      case DOWN:
        this.camera.adjustLongitude(PI/100); // Déplacement bas
        break;
    }
  } else {
    switch (key) {
      case 'h':
      case 'H':
        this.workspace.toggle(); // cache le gizmo en gardant le grillage
        break;
      case '+':
      case 'p':
      case 'P':
        this.camera.adjustRadius(-10);  // permet de zoomer en avant
        break;
      case '-':
      case 'm':
      case 'M':
        this.camera.adjustRadius(10); // permet de zoomer en arrière
        break;
      case 'l':
      case 'L':
        this.camera.toggle(); // pour mieux éclaircir la carte 3D
        break;
        // Déplacement avec les touches du clavier pour un gaucher
      case 'q':
      case 'Q':
        this.camera.adjustColatitude(-PI/100); // Déplacement gauche  
        break;
      case 's':
      case 'S':
        this.camera.adjustColatitude(PI/100); // Déplacement droite
        break;
      case 'z':
      case 'Z':
        this.camera.adjustLongitude(-PI/100); // Déplacement haut
        break;
      case 'w':
      case 'W':
        this.camera.adjustLongitude(PI/100); // Déplacement bas
        break;
      case 'g':
      case 'G': 
        this.gpx.toggle();
        break;
       case 'r':
         this.roads.toggle();
         break; 
       case 'R':
         this.railways.toggle();
         break;
       case 'b':
       case 'B':
    //     this.buildings.toggle();
         break;
        case 'c':
        case 'C':
          this.land.toggle();
          break;
      }
    }
}
    void mouseDragged() { // ne fonctionne qu'avec une vraie souris
  if (mouseButton== CENTER){
    // Camera Horizontal
    float dx = pmouseX - mouseX;
    this.camera.adjustColatitude(dx*0.002); //permet  de se déplacer de droite à gauche avec la souris en appuyant sur la molette
    // Camera Vertical
    float dy = pmouseY - mouseY;
    this.camera.adjustLongitude(dy*0.002); //permet  de se déplacer de haut en bas avec la souris en appuyant sur la molette
  }
}

void mousePressed() {
  if (mouseButton == LEFT)
    this.gpx.clic(mouseX, mouseY); //affiche le nom de chaque emplacement GPS
}
