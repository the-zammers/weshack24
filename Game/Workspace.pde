class Workspace {
     Radical left;
     Radical right;

     Workspace() {
        left = null;
        right = null;
     }

    PVector leftPos = new PVector(sidebar.boundary * 1/4, height/4);
    PVector rightPos = new PVector(sidebar.boundary * 3/4, height/4);
    PVector combinedPos = new PVector(sidebar.boundary * 1/2, height*3/4);

     void draw() {
        stroke(#000000);
        noFill();
        rectMode(CENTER);
        square(leftPos.x, leftPos.y, 2 * sidebar.radicalSize);
        square(rightPos.x, rightPos.y, 2 * sidebar.radicalSize);

        textSize(2 * sidebar.radicalSize);
        textAlign(CENTER, CENTER);
        if(left != null) text(left.character, leftPos.x, leftPos.y);
        text('+', sidebar.boundary / 2, height / 4);
        if(right != null) text(right.character, rightPos.x, rightPos.y);
        text('=', sidebar.boundary / 2, height / 2);
        text(levelOver ? levels[levelCounter].goal.character : '?', combinedPos.x, combinedPos.y);

        textSize(2 * sidebar.radicalSize / 4);
        textAlign(CENTER, TOP);
        text(getLevelDescription(levelCounter), sidebar.boundary/2, sidebar.padding);
        textAlign(CENTER, BOTTOM);
        text(!levelOver ? "Level " + (levelCounter + 1) : "Click to Continue", sidebar.boundary/2, height-sidebar.padding);

        textSize(2 * sidebar.radicalSize / 3);

        textAlign(CENTER, BOTTOM);
        if(left != null) text(left.pinyin, leftPos.x, leftPos.y - sidebar.radicalSize);
        if(right != null) text(right.pinyin, rightPos.x, rightPos.y - sidebar.radicalSize);
        text(levels[levelCounter].goal.pinyin, combinedPos.x, combinedPos.y - sidebar.radicalSize);

        textAlign(CENTER, TOP);
        if(left != null) text(left.meaning, leftPos.x, leftPos.y + sidebar.padding + sidebar.radicalSize);
        if(right != null) text(right.meaning, rightPos.x, rightPos.y + sidebar.padding + sidebar.radicalSize);
        text(levels[levelCounter].goal.meaning, combinedPos.x, combinedPos.y + sidebar.radicalSize);
     }
}
