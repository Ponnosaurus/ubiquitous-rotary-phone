String[] uniqueWords;
PFont customFont;

void setup() {
  size(700, 600);
  String file = "uniquewords.txt";
  uniqueWords = loadStrings(file);
  customFont = createFont("Open Sans", 28);
  noLoop();
}

void draw() {
  background(255);
  textFont(customFont);
  int posX = 0;
  int posY = 32;
  ArrayList<String> displayedWords = new ArrayList<String>();

  for (int i = 0; i < uniqueWords.length; i++) {
    int randomIndex = (int)random(0, uniqueWords.length);

    // Check if word already displayed
    if (displayedWords.contains(uniqueWords[randomIndex])) {
      continue;
    }

    // Color based on its first character a-i = red,
    // j-r = green, r-z = blue
    char firstChar = uniqueWords[randomIndex].charAt(0);
    if ('a' <= firstChar && firstChar <= 'i') {
      fill(#FF5733);  // red
    } else if ('j' <= firstChar && firstChar <= 'r') {
      fill(#33FF57);  // green
    } else {
      fill(#3357FF);  // blue
    }

    int nextWordWidth = (int)textWidth(uniqueWords[randomIndex] + " "); 
    if (posX + nextWordWidth > 700) {
      if (posY > 570) {
        break; // stop when the canvas is filled up
      }
      posY += 32;
      posX = 0;
      i--; // try again with the same word on the next line
      continue;
    } 

    text(uniqueWords[randomIndex], posX, posY);
    displayedWords.add(uniqueWords[randomIndex]);
    posX += nextWordWidth;
  }
}

void mousePressed() {
  background(255);
  redraw();
}
