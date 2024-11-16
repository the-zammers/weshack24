class Radical {
  char character;
  String meaning;
  String pinyin;
  
  Radical(char c, String m, String p) {
    character = c;
    meaning = m;
    pinyin = p;
    
  }
  
  /* Draws the Radical as a square with size width & length, with its
   * top left corner at posX and posY, and the character at the center of
   * the square. */
  void draw(float posX, float posY, float size) {
    square(posX, posY, size);
    text(meaning, (posX + size) / 2, (posY + size) / 2);
  }
}
