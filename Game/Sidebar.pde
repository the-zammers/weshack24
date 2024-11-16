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
        stroke(#000000);
        strokeWeight(5);
        fill(#44FFD2);
        rectMode(CORNERS);
        rect(this.boundary, -3, width+3, height+3);
        
        textAlign(LEFT, CENTER);
        fill(#000000);
        for(int i=0; i<currLevel.components.length; i++) {
            textSize(this.radicalSize);
            text(currLevel.components[i].character, this.boundary + this.padding, i*this.radicalSize + this.radicalSize / 2);
            textSize(this.radicalSize / 3);
            text(currLevel.components[i].meaning, this.boundary + this.padding + this.radicalSize + this.padding, i*this.radicalSize + this.radicalSize / 2 - this.radicalSize / 5);
            text(currLevel.components[i].pinyin, this.boundary + this.padding + this.radicalSize + this.padding, i*this.radicalSize + this.radicalSize / 2 + this.radicalSize / 5);
        }
    }
}
