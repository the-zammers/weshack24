class Workspace {
     Radical left;
     Radical right;
     Radical combined;

     Workspace() {
        left = null;
        right = null;
        combined = null;
     }

    PVector leftPos = new PVector(sidebar.boundary * 1/4, height/2);
    PVector rightPos = new PVector(sidebar.boundary * 3/4, height/2);
    PVector combinedPos = new PVector(sidebar.boundary * 1/2, height*3/4);

     void draw() {
        stroke(#000000);
        noFill();
        rectMode(CENTER);
        textAlign(CENTER, CENTER);
        textSize(2 * sidebar.radicalSize);
        square(leftPos.x, leftPos.y, 2 * sidebar.radicalSize);
        if(left != null) text(left.character, leftPos.x, leftPos.y);
        text('+', sidebar.boundary / 2, height / 2);
        square(rightPos.x, rightPos.y, 2 * sidebar.radicalSize);
        if(right != null) text(right.character, rightPos.x, rightPos.y);
     }
}
