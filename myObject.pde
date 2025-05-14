class myObject {
  float xPos, yPos, xVel, yVel, diameter;
  color c1;
  int bornTime, timeDuration;

  // Alterar propriedades de diametro/cor da bola sem afetar as variaveis originais para que a colisão continue igual
  float visualDiameter; 
  color visualColor;
  ArrayList<PVector> trail;
  VisualEffect effect;

  myObject() {
    xPos = random(width);
    yPos = random(height);
    xVel = random(-5, 5);
    yVel = random(-5, 5);
    diameter = random(100, 200);
    c1 = color(random(255), random(255), random(255));
    bornTime = millis();
    timeDuration = int(random(5000, 15000));
    trail = new ArrayList<PVector>();

    // escolher efeito aleatorio
    int r = int(random(4));

    switch (r) {
      case 0:
        effect = new PulsatingEffect();
        break;
      case 1:
        effect = new ColorCycleEffect();
        break;
      case 2:
        effect = new TrailEffect();
        break;
      case 3:
        effect = new OrbitEffect();
        break;
      default:
        effect = new PulsatingEffect(); // fallback
        break;
    }


    visualDiameter = diameter;
    visualColor = c1;
  }

  void updateIt() {
    xPos += xVel;
    yPos += yVel;
  }

  void worldCollision() {
    if (xPos > width - diameter * 0.5) {
      xVel = -xVel;
      xPos = width - diameter * 0.5;
    }
    if (xPos < diameter * 0.5) {
      xVel = -xVel;
      xPos = diameter * 0.5;
    }
    if (yPos > height - diameter * 0.5) {
      yVel = -yVel;
      yPos = height - diameter * 0.5;
    }
    if (yPos < diameter * 0.5) {
      yVel = -yVel;
      yPos = diameter * 0.5;
    }
  }

  boolean stillAlive() {
    return millis() - bornTime < timeDuration;
  }

  void setPos(float x, float y) {
    xPos = x;
    yPos = y;
  }

  void drawIt() {
    effect.apply(this); // atualizar visualDiameter e visualColor
    fill(visualColor);
    ellipse(xPos, yPos, visualDiameter, visualDiameter);
  }
}
