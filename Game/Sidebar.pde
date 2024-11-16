class Sidebar {
    int boundary;
    int padding;
    int radicalSize;
    
    Sidebar() {
        this.boundary = width*3/5;
        this.padding = 10;
        this.radicalSize = height/12;
    }

    void drawSidebar() {
        noStroke();
        fill(#44FFD2);
        rectMode(CORNERS);
        rect(this.boundary, 0, width, height);
        
        stroke(#000000);
        strokeWeight(5);
        line(this.boundary, 0, this.boundary, height);

        textSize(this.radicalSize);
        textAlign(LEFT, TOP);
        fill(#000000);
        for(int i=0; i<currLevel.components.length; i++) {
            text(currLevel.components[i], this.boundary + this.padding, i*this.radicalSize);
        }
    }
}
