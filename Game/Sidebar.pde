class Sidebar {
    
    Sidebar() {}

    void drawSidebar() {
        noStroke();
        fill(#44FFD2);
        rectMode(CORNERS);
        rect(width*3/5, 0, width, height);
        
        stroke(#000000);
        strokeWeight(5);
        line(width*3/5, 0, width*3/5, height);

        textSize(height/12);
        textAlign(LEFT, TOP);
        fill(#000000);
        for(int i=0; i<currLevel.components.length; i++) {
            text(currLevel.components[i], width*3/5, i*height/12);
        }
    }
}
