class Level {
    char goal;
    String[] components;

    Level(char goal, String[] components) {
        this.goal = goal;
        this.components = components;
    }


    void drawLevel() {
        fill(#000000);
        textAlign(CENTER, TOP);
        text("Goal: " + this.goal, width*3/5/2, 0);
    }
}

    
