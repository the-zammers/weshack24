PFont font;
Level currLevel;
Sidebar sidebar;
// Workspace workspace;
Radical held;

void setup() {
    size(800, 800);
    System.out.println("hello, world");
    currLevel = new Level(new Radical('好', "hǎo", "good"), new Radical[] {new Radical('女', "nǚ", "woman"), new Radical('人', "rén", "person"), new Radical('子', "zǐ", "child"), new Radical('工', "gōng", "work")});
    sidebar = new Sidebar();
    font = createFont("NotoSansSC-Regular.ttf", sidebar.radicalSize);
    textFont(font);
    held = null;
}

void draw() {
    background(#FFF0F5);
    currLevel.drawLevel();
    sidebar.drawSidebar();
    if(held != null) {
        held.draw(mouseX, mouseY, sidebar.radicalSize);
    }
}

void mousePressed() {
    if(mouseButton == LEFT
            && 0 < mouseX - sidebar.boundary - sidebar.padding
            && mouseX - sidebar.boundary - sidebar.padding < sidebar.radicalSize
            && mouseY / sidebar.radicalSize < currLevel.components.length
      ) {
        System.out.println("boop! radical " + (mouseY / sidebar.radicalSize) );
        held = currLevel.components[mouseY / sidebar.radicalSize];
    }
}

void mouseReleased() {
    held = null;
}
