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

        fill(#000000);
        for(int i=0; i<currLevel.components.length; i++) {
            textAlign(LEFT, CENTER);
            textSize(this.radicalSize);
            text(currLevel.components[i].character, this.boundary + this.padding, i*this.radicalSize + this.radicalSize / 2);
            textSize(this.radicalSize / 3);
            text(currLevel.components[i].meaning, this.boundary + this.padding + this.radicalSize + this.padding, i*this.radicalSize + this.radicalSize / 2 - this.radicalSize / 5);
            textSize(this.radicalSize / 3);
            text(currLevel.components[i].pinyin, this.boundary + this.padding + this.radicalSize + this.padding, i*this.radicalSize + this.radicalSize / 2 + this.radicalSize / 5);
        }
    }
}
