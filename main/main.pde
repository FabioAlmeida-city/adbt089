//Ambient music provided by Segey Cheremisinov on freemusicarchive.org under the Creative Commons BY-NC 4.0 license. (https://creativecommons.org/licenses/by-nc/4.0/)
//https://files.freemusicarchive.org/storage-freemusicarchive-org/music/ccCommunity/Sergey_Cheremisinov/The_Healing/Sergey_Cheremisinov_-_05_-_The_Healing.mp3

import processing.sound.*;
ArrayList<Droplet> Droplets = new ArrayList<Droplet>();
ArrayList<Droplet> DropletsToRemove = new ArrayList<Droplet>();
float ratePerFrame = 1.2;
SoundFile music;
void setup() {
  background(9,71,143);
  size(1000,500);
  surface.setResizable(true);
  music = new SoundFile(this, "music.mp3");
  music.loop(1,0.25);
}
void draw() {
  frameRate(90); // Attempt to lock the frameRate to 80
  noStroke(); // Give all objects no stroke
  for (Droplet droplet : DropletsToRemove) Droplets.remove(droplet); // Remove each droplet in DropletsToRemove (doing this in the main update loop would product an error)
  DropletsToRemove.clear(); // Clear the removed droplets
  fill(9,71,143,50); // The next 3 lines handle creating a semi-transparent rectangle and then set rendering back to normal
  rect(0,0,width,height);
  fill(255,255);
  for (float i = 0; i < ratePerFrame; i+=(1/ratePerFrame)) Droplets.add(new Droplet()); // Add droplets per ratePerFrame
  for (Droplet droplet : Droplets) { // Update each droplet, if the update is no longer valid, add it to be removed
    if(droplet.update() == false) DropletsToRemove.add(droplet);
  }
  for (Droplet droplet : Droplets) {
    ellipse(droplet.getX(),droplet.getY(),droplet.getRadius(),droplet.getRadius()); // Render each droplet
    for (Droplet drop : Droplets) {
      if (droplet.closeToDroplet(drop) && droplet.getRadius() > drop.getRadius()) { // If the droplet is touching another droplet, combine them
        droplet.increaseSize(drop);
        DropletsToRemove.add(drop);
      } else if (droplet.closeToDroplet(drop)) {
        drop.increaseSize(droplet);
        DropletsToRemove.add(droplet);
      }
    }
  }
}
