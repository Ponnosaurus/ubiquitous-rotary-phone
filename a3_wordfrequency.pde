String[] lines; 
int maxFrequency = 0; 
int xPadding = 60; 
int yPadding = 60;
int barWidth = 10; 
int canvasWidth; 
PFont font;

void setup() {
  size(1600, 600);
  lines = loadStrings("wordfrequency.txt");
  parseData();
  font = createFont("Arial", 16);
  textFont(font);
  canvasWidth = xPadding * 2 + maxFrequency * barWidth;
}

void draw() {
  background(255);
  drawVisualization();
}

void parseData() {
  for (String line : lines) {
    String[] parts = split(line, ':');
    int frequency = int(parts[0].trim());
    if (frequency > maxFrequency) {
      maxFrequency = frequency;
    }
  }
}

void drawVisualization() {
  int x = xPadding;
  int y = height - yPadding;
  for (int i = 1; i <= maxFrequency; i++) {
    int wordCount = 0;
    boolean hasData = false; 
    for (String line : lines) {
      String[] parts = split(line, ':');
      int frequency = int(parts[0].trim());
      int count = int(parts[1].trim());
      if (frequency == i) {
        wordCount += count;
        hasData = true;
      }
    }
    if (hasData) {
      int barHeight = int(map(wordCount, 0, maxFrequency, 0, height - 2 * yPadding));
      fill(0, 0, 255);
      rect(x, y - barHeight, barWidth, barHeight);
      x += barWidth;
    }
  }
  fill(0);
  textAlign(CENTER);
  text("Word Frequency", width / 2, height - 10);
  text("Number of Words", xPadding / 2, y - maxFrequency / 2);
  textSize(20);
  text("Word Frequency Distribution", width / 2, yPadding / 2);
}
