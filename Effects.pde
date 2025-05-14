abstract class VisualEffect {
  abstract void apply(myObject obj);  
}

// Aumentar/diminuir tamanho da bola
class PulsatingEffect extends VisualEffect {
  float offset;

  PulsatingEffect() {
    offset = random(TWO_PI);
  }

  void apply(myObject obj) {
    float pulse = sin((millis() * 0.005) + offset);
    obj.visualDiameter = obj.diameter + 10 * pulse;
    obj.visualColor = obj.c1;
  }
}

// RGB
class ColorCycleEffect extends VisualEffect {
  void apply(myObject obj) {
    float hueShift = (millis() * 0.05f) % 255;
    colorMode(HSB, 255);
    obj.visualColor = color(hueShift, 200, 255);
    colorMode(RGB, 255);
    obj.visualDiameter = obj.diameter;
  }
}

// Rastro
class TrailEffect extends VisualEffect {
  int maxTrailLength = 20;

  void apply(myObject obj) {
    obj.trail.add(new PVector(obj.xPos, obj.yPos));
    
    // Tamanho do rastro
    if (obj.trail.size() > maxTrailLength) {
      obj.trail.remove(0);
    }

    // Desenhar
    for (int i = 0; i < obj.trail.size(); i++) {
      PVector pos = obj.trail.get(i);
      float alpha = map(i, 0, obj.trail.size(), 50, 200);
      fill(red(obj.c1), green(obj.c1), blue(obj.c1), alpha);
      float size = map(i, 0, obj.trail.size(), 5, obj.diameter);
      ellipse(pos.x, pos.y, size, size);
    }

    obj.visualDiameter = obj.diameter;
    obj.visualColor = obj.c1;
  }
}

class OrbitEffect extends VisualEffect {
  void apply(myObject obj) {
    float angle = millis() * 0.01f;
    float orbitRadius = obj.diameter * 0.75;

    float orbitX = obj.xPos + cos(angle) * orbitRadius;
    float orbitY = obj.yPos + sin(angle) * orbitRadius;

    // Draw main object
    fill(obj.c1);
    ellipse(obj.xPos, obj.yPos, obj.diameter, obj.diameter);

    // Draw orbiting dot
    fill(obj.c1/2);
    ellipse(orbitX, orbitY, obj.diameter * 0.2, obj.diameter * 0.2);

    obj.visualColor = obj.c1;
    obj.visualDiameter = obj.diameter;
  }
}
