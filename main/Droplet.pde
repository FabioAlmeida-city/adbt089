class Droplet {
  private float x;
  private float y;
  private float radius;
  private float lifespan;
  private float aliveSince = frameCount;
  private float xBias;
  private float limitRadius = 15;
  public Droplet() {
    this.x = random(0,width);
    this.y = random(0,height);
    this.radius = random(1,5);
    this.lifespan = random(120,500);
    this.xBias = random(-2,2);
  }
  public float getX() {
    return this.x;  
  }
  public float getY() {
    return this.y;
  }
  public float getRadius() {
    return this.radius;
  }
  public float getLifespan() {
    return this.lifespan;
  }
  public float getBias() {
    return this.xBias; 
  }
  public void increaseSize(Droplet target) {
    if (this.radius < limitRadius) {
      this.radius += target.getRadius()/2;
      this.lifespan += target.getLifespan()/2;
      this.xBias += target.getBias()/2;
    }
  }
  public boolean closeToDroplet(Droplet target) {
    float distanceBetween = dist(target.getX(), target.getY(), this.x, this.y);
    if (distanceBetween <= this.radius && distanceBetween != 0) {
      return true;
    }
    return false;
  }
  public boolean update() {
    noiseSeed((long)(xBias));
    this.x += noise(xBias);
    this.y += random(0+this.radius,1+this.radius);
    this.radius -= map(frameCount - aliveSince, 0,this.lifespan, 0,limitRadius)/lifespan;
    if (this.y < height && (this.x > 0 || this.x < width) && lifespan > frameCount - aliveSince && this.radius > 0) return true;
    return false;
  }
}
