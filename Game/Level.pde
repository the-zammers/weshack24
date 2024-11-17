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
    
    /* Returns true if leftSide and rightSide match the components of goal. */
    boolean isGoal(Radical leftSide, Radical rightSide) {
      if (leftSide.character != this.components[0].character) {
        return false;
      }
      if (rightSide.character != this.components[1].character) {
        return false;
      }
      
      return true;
      
    }
}

    
