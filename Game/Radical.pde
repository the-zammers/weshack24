class Radical {
  char character;
  String pinyin;
  String meaning;
  
  Radical(char c, String p, String m) {
    character = c;
    pinyin = p;
    meaning = m;
    
  }
  
  /* Draws the Radical as a square with size width & length, with its
   * top left corner at posX and posY, and the character at the center of
   * the square. */
  void draw(float posX, float posY, float size) {
    stroke(#000000);
    //noFill();
    //rectMode(CENTER);
    //square(posX, posY, size);
    textAlign(CENTER, CENTER);
    textSize(sidebar.radicalSize);
    text(character, posX, posY);
  }
}
