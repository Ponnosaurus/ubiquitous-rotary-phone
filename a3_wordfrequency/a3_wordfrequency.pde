String[] lines;
int maxCount = 0;
int xPadding = 60;
int yPadding = 60;
int barWidth = 10;
PFont font;
int[][] frequencyRanges = {
  {1, 1},
  {2, 5},
  {6, 50},
  {51, 1600},
};
int numRanges;

void setup() {
  size(1600, 600);
  lines = loadStrings("wordfrequency.txt");
  numRanges = frequencyRanges.length;
  int availableWidth = width - 2 * xPadding;
  barWidth = availableWidth / numRanges;  
  parseData();
  font = createFont("Times New Roman", 28);
  textFont(font);
  smooth();
}

void draw() {
  background(255);
  drawVisualization();
  displayInfoOnHover();
}

void parseData() {
  for (int[] range : frequencyRanges) {
    int totalForRange = 0;
    for (String line : lines) {
      String[] parts = split(line, ':');
      int frequency = int(parts[0].trim());
      int count = int(parts[1].trim());
      if (frequency >= range[0] && frequency <= range[1]) {
        totalForRange += count;
      }
    }
    if (totalForRange > maxCount) {
      maxCount = totalForRange;
    }
  }
}

void drawVisualization() {
  int x = xPadding;
  int y = height - yPadding;

  // Axes
  stroke(0);
  line(xPadding, yPadding - 20, xPadding, height - yPadding);
  line(xPadding, height - yPadding, width - xPadding, height - yPadding);

  for (int[] range : frequencyRanges) {
    int totalForRange = 0;
    for (String line : lines) {
      String[] parts = split(line, ':');
      int frequency = int(parts[0].trim());
      int count = int(parts[1].trim());
      if (frequency >= range[0] && frequency <= range[1]) {
        totalForRange += count;
      }
    }
    if (totalForRange > 0) {
      int barHeight = int(map(totalForRange, 0, maxCount, 0, height - 2 * yPadding));
      float normalizedValue = map(totalForRange, 0, maxCount, 0, 1);
      fill(lerpColor(color(255, 0, 0), color(0, 255, 0), normalizedValue));
      rect(x, y - barHeight, barWidth, barHeight);
      x += barWidth;
    }
  }
  fill(0);
  textAlign(CENTER, CENTER);
  text("Frequency Ranges", width / 2, height - 20);
  //Rotate Number of Words to run along y-axis
  pushMatrix();
  translate(20, height / 2);
  rotate(-PI / 2);
  text("Number of Words", 0, 0);
  popMatrix();
  
  textSize(20);
  text("Word Frequency Distribution", width / 2, yPadding / 2);
}

void displayInfoOnHover() {
  int hoveredBar = int((mouseX - xPadding) / barWidth);
  if (hoveredBar >= 0 && hoveredBar < numRanges) {
    int[] range = frequencyRanges[hoveredBar];
    int totalForRange = 0;
    for (String line : lines) {
      String[] parts = split(line, ':');
      int frequency = int(parts[0].trim());
      int count = int(parts[1].trim());
      if (frequency >= range[0] && frequency <= range[1]) {
        totalForRange += count;
      }
    }
    fill(0);
    text("Frequency: " + range[0] + "-" + range[1], mouseX, mouseY - 20);
    text("Words: " + totalForRange, mouseX, mouseY);
  }
}
