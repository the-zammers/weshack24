PFont font;
int levelCounter; // use this to index into levels, perhaps.
Level currLevel; 
Sidebar sidebar;
Workspace workspace;
Radical held;
int numOfRadicals = 14;
int numOfLevels = 14;
Radical[] radicals = new Radical[numOfRadicals];
Level[] levels = new Level[numOfLevels];


void setup() {
    size(800, 800);
    System.out.println("hello, world");
    levelCounter = 0;
    currLevel = new Level(new Radical('林', "lín", "forest"), new Radical[] {new Radical('木', "mù", "wood"), new Radical('人', "rén", "person"), new Radical('子', "zǐ", "child"), new Radical('工', "gōng", "work")});
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
      Radical[] components = new Radical[2];
      components[0] = new Radical(data[3].charAt(0));
      components[1] = new Radical(data[4].charAt(0));
      // Puts the data into levels.
      levels[i] = new Level(goal, components);
    }
    
    
    
}

void draw() {
    background(#FFF0F5);
    currLevel.drawLevel();
    sidebar.drawSidebar();
    workspace.draw();
    if(held != null) {
        held.draw(mouseX, mouseY, sidebar.radicalSize);
    }
}

void mousePressed() {
    // If mouse is in sidebar
    if(mouseButton == LEFT
            && 0 < mouseX - sidebar.boundary - sidebar.padding
            && mouseX - sidebar.boundary - sidebar.padding < sidebar.radicalSize
            && mouseY / sidebar.radicalSize < currLevel.components.length
      ) {
        System.out.println("boop! radical " + (mouseY / sidebar.radicalSize) );
        held = currLevel.components[mouseY / sidebar.radicalSize];
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
    if(mouseButton == LEFT && inBox(workspace.leftPos, sidebar.radicalSize, new PVector(mouseX, mouseY))) {
        workspace.left = held;
    }
    if(mouseButton == LEFT && inBox(workspace.rightPos, sidebar.radicalSize, new PVector(mouseX, mouseY))) {
        workspace.right = held;
    }
    held = null;
    
    // Check if the left and right workspace match the level's goal. 
    if (workspace.left != null && workspace.right != null) {
      if (levels[levelCounter].isGoal(workspace.left, workspace.right)) {
        // Make this actually do stuff on the display later :)
        System.out.println("it matches!");
      }
    }
}
