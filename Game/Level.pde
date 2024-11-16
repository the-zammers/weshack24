class Level {
    Radical goal;
    Radical[] components;

    Level(Radical goal, Radical[] components) {
        this.goal = goal;
        this.components = components;
    }


    void drawLevel() {
        fill(#000000);
        textAlign(CENTER, TOP);
        textSize(sidebar.radicalSize);
        text("Goal: " + this.goal.character, sidebar.boundary/2, 0);
    }
}

    
