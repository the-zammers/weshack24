import processing.sound.*;
PFont font;
int levelCounter; // use this to index into levels, perhaps.
Sidebar sidebar;
Workspace workspace;
Radical held;
boolean inAnimation;
boolean success;
int animationFrame;
float shakeMagnitude;
boolean levelOver;
boolean gameOver;
int numOfRadicals = 17;
int numOfLevels = 17;
Radical[] radicals = new Radical[numOfRadicals];
Level[] levels = new Level[numOfLevels];
boolean soundPlayed;
SoundFile successSound;
SoundFile failureSound;


void setup() {
    size(800, 800);
    inAnimation = true;
    levelCounter = 0;
    sidebar = new Sidebar();
    font = createFont("NotoSansSC-Regular.ttf", sidebar.radicalSize);
    textFont(font);
    workspace = new Workspace();
    held = null;
    
    // Reads in input from the all_radicals text file. 
    String[] inputRadicals = loadStrings("all_radicals.txt");
    for (int i = 0; i < inputRadicals.length; i++) {
      String[] data = split(inputRadicals[i], "-");
      // the .charAt(0) converts String into char
      // Puts the data into radicals.
      radicals[i] = new Radical(data[0].charAt(0), data[1], data[2]);
    }
    
    // Reads in input from the levels text file
    String[] inputLevels = loadStrings("levels.txt");
    for (int i = 0; i < inputLevels.length; i++) {
      // Just some data processing.
      String[] data = split(inputLevels[i], "-");
      Radical goal = new Radical(data[0].charAt(0), data[1], data[2]);
      char leftComponent = data[3].charAt(0);
      char rightComponent = data[4].charAt(0);
      // Puts the data into levels.
      levels[i] = new Level(goal, leftComponent, rightComponent);
    }
    inAnimation = false;
    levelOver = false;
    gameOver = false;
    soundPlayed = false;
    successSound = new SoundFile(this, "success.wav");
    failureSound = new SoundFile(this, "failure.wav");
}

void draw() {
    background(#FFF0F5);

    if(inAnimation && success) {
      
        if (!soundPlayed && !gameOver) successSound.play();
        soundPlayed = true;
        translate(width/2, height/2);
        scale(1 + 0.05 * sin((float) animationFrame * PI / 10));
        translate(-width/2, -height/2);
        if(animationFrame-- < 0) {
          inAnimation = false;
          soundPlayed = false;
        }
    }
    if(inAnimation && !success) {
        if (!soundPlayed) failureSound.play();
        soundPlayed = true;
        float dx = (random(2)>1 ? 1 : -1) * shakeMagnitude;
        float dy = (random(2)>1 ? 1 : -1) * shakeMagnitude;
        translate(dx, dy);
        if(animationFrame-- < 0) shakeMagnitude--;
        if(shakeMagnitude < 0) {
          inAnimation = false;
          soundPlayed = false;
        }
    }

    if(sidebar.scrollBy < 0) sidebar.scrollBy++;
    if(sidebar.scrollBy > (numOfRadicals - 12) * 2) sidebar.scrollBy--;
    sidebar.drawSidebar(radicals);
    workspace.draw();
    if(held != null) {
        held.draw(mouseX, mouseY, sidebar.radicalSize);
    }

    if(inAnimation) {
        noStroke();
        rectMode(CENTER);
        fill(success ? #00FF00 : #FF0000, 100);
        if (gameOver) fill(#FFFFFF);
        rect(width/2, height/2, width + 4*sidebar.padding, height + 4*sidebar.padding);
    }
    
    if (gameOver) {
      rectMode(CENTER);
      fill(#FFFFFF);
      rect(width/2, height/2, width - 150, height/2 + 150);
      textSize(56);
      textAlign(CENTER);
      fill(#000000);
      text("CONGRATULATIONS!", width/2, height/2 - 50);
      text("You win!", width/2, height/2 + 50);
      inAnimation = true;
      
    
    }
}

void mousePressed() {
    if(inAnimation || levelOver) return;
    // If mouse is in sidebar
    if(mouseButton == LEFT
            && 0 < mouseX - sidebar.boundary - sidebar.padding
            && mouseX - sidebar.boundary - sidebar.padding < sidebar.radicalSize
            && 0 <= (mouseY + sidebar.scrollBy * sidebar.radicalSize / 2) / sidebar.radicalSize
            && (mouseY + sidebar.scrollBy * sidebar.radicalSize / 2) / sidebar.radicalSize < radicals.length
      ) {
        held = radicals[(mouseY + sidebar.scrollBy * sidebar.radicalSize / 2) / sidebar.radicalSize];
    }
    // If mouse is in left workspace
    if(mouseButton == LEFT && inBox(workspace.leftPos, sidebar.radicalSize, new PVector(mouseX, mouseY))) {
        held = workspace.left;
        workspace.left = null;
    }
    // If mouse is in right workspace
    if(mouseButton == LEFT && inBox(workspace.rightPos, sidebar.radicalSize, new PVector(mouseX, mouseY))) {
        held = workspace.right;
        workspace.right = null;
    }
}

boolean inBox(PVector bpos, int size, PVector mpos) {
    return size > Math.abs(mpos.x - bpos.x) && size > Math.abs(mpos.y - bpos.y);
}

void mouseReleased() {
    if(inAnimation || levelOver) return;
    boolean dropped = false;
    if(mouseButton == LEFT && inBox(workspace.leftPos, sidebar.radicalSize, new PVector(mouseX, mouseY))) {
        workspace.left = held;
        dropped = true;
    }
    if(mouseButton == LEFT && inBox(workspace.rightPos, sidebar.radicalSize, new PVector(mouseX, mouseY))) {
        workspace.right = held;
        dropped = true;
    }
    held = null;
    
    // Check if the left and right workspace match the level's goal. 
    if (dropped && workspace.left != null && workspace.right != null) {
      if (levels[levelCounter].isGoal(workspace.left, workspace.right)) {
        // Make this actually do stuff on the display later :)
        success = true;
        levelOver = true;
      }
      else {
        success = false;
      }
      inAnimation = true;
      animationFrame = 10;
      shakeMagnitude = sidebar.padding * 3/4;
    }
}

void mouseClicked() {
    if(inAnimation) return;
    if(levelOver && mouseButton == LEFT && levelCounter < (numOfLevels - 1) ){
        levelCounter++;
        levelOver = false;
        workspace.left = null;
        workspace.right = null;
        held = null;
    }
    // If the game is complete, after going thru all levels
    else if (levelOver && levelCounter == (numOfLevels - 1) ){
      gameOver = true;
      
    }
}

void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    sidebar.scrollBy += e;
}

String getLevelDescription(int index) {
    if(index < 0) return "Debug Level";
    if(index < 2) return "Semantic Compounds";
    if(index < 6) return "PHONOsemantic Compounds";
    if(index < 10) return "PhonoSEMANTIC Compounds";
    if(index < 12) return "Challenge A";
    if(index < 17) return "Challenge B";
    return "Debug Level";
}
