PFont font;
int levelCounter; // use this to index into levels, perhaps.
Sidebar sidebar;
Workspace workspace;
Radical held;
boolean inAnimation;
boolean success;
int animationFrame;
float shakeMagnitude;
int numOfRadicals = 17;
int numOfLevels = 17;
Radical[] radicals = new Radical[numOfRadicals];
Level[] levels = new Level[numOfLevels];


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
}

void draw() {
    background(#FFF0F5);

    if(inAnimation) {
        float dx = (random(2)>1 ? 1 : -1) * shakeMagnitude;
        float dy = (random(2)>1 ? 1 : -1) * shakeMagnitude;
        translate(dx, dy);
        if(animationFrame-- < 0) shakeMagnitude--;
        if(shakeMagnitude < 0) inAnimation = false;
    }

    levels[levelCounter].drawLevel();
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
        rect(width/2, height/2, width + 4*sidebar.padding, height + 4*sidebar.padding);
    }
}

void mousePressed() {
    if(inAnimation) return;
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
    if(inAnimation) return;
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
      }
      else {
        success = false;
      }
      inAnimation = true;
      animationFrame = 10;
      shakeMagnitude = sidebar.padding;
    }
}


void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    sidebar.scrollBy += e;
}
