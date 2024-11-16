Level currLevel;
Sidebar sidebar;
// Workspace workspace;

void setup() {
    size(800, 800);
    System.out.println("hello, world");
    currLevel = new Level('Q', new String[] {"than", "ks", "okay", "you"});
    sidebar = new Sidebar();
}

void draw() {
    background(#FFF0F5);
    currLevel.drawLevel();
    sidebar.drawSidebar();
}
