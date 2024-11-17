class Level {
    Radical goal;
    char leftComponent;
    char rightComponent;

    Level(Radical goal, char leftComponent, char rightComponent) {
        this.goal = goal;
        this.leftComponent = leftComponent;
        this.rightComponent = rightComponent;
    }

    /* Returns true if leftSide and rightSide match the components of goal. */
    boolean isGoal(Radical leftSide, Radical rightSide) {
      return (leftSide.character == this.leftComponent) && (rightSide.character == this.rightComponent);
    }
}

    
