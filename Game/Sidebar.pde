class Sidebar {
    int boundary;
    int padding;
    int radicalSize;
    int scrollBy;
    
    Sidebar() {
        this.boundary = width*3/5;
        this.padding = 10;
        this.radicalSize = height/12;
        this.scrollBy = 0;
    }

    void drawSidebar(Radical[] radicals) {
        noStroke();
        fill(#44FFD2);
        rectMode(CORNERS);
        rect(this.boundary, -2*padding, width+2*padding, height+2*padding);
        stroke(#000000);
        strokeWeight(5);
        line(this.boundary, -2*padding, this.boundary, height+2*sidebar.padding);
        
        textAlign(LEFT, CENTER);
        fill(#000000);
        pushMatrix();
        translate(0, -this.scrollBy * this.radicalSize / 2);
        for(int i=0; i<radicals.length; i++) {
            textSize(this.radicalSize);
            text(radicals[i].character, this.boundary + this.padding, i*this.radicalSize + this.radicalSize / 2);
            textSize(this.radicalSize / 3);
            text(radicals[i].pinyin, this.boundary + this.padding + this.radicalSize + this.padding, i*this.radicalSize + this.radicalSize / 2 - this.radicalSize / 5);
            text(radicals[i].meaning, this.boundary + this.padding + this.radicalSize + this.padding, i*this.radicalSize + this.radicalSize / 2 + this.radicalSize / 5);
        }
        popMatrix();
    }
}
