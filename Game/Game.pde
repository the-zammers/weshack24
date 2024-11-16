Level currLevel;
Sidebar sidebar;
// Workspace workspace;
String held;

void setup() {
    size(800, 800);
    System.out.println("hello, world");
    currLevel = new Level('Q', new String[] {"than", "ks", "okay", "you"});
    sidebar = new Sidebar();
    held = null;
}

void draw() {
    background(#FFF0F5);
    currLevel.drawLevel();
    sidebar.drawSidebar();
    if(held != null) {
        text(held, mouseX, mouseY);
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
