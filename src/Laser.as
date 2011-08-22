package
{
  import org.flixel.*;

  public class Laser extends LaserPiece
  {
    [Embed(source='../data/laser.png')] private var ImgLaser:Class;

    public function Laser(X:Number, Y:Number):void {
      super(X,Y);
      loadGraphic(ImgLaser, true, true, 240, 24);
      addAnimation("fire", [0,1], 30);
      blend = "add";
      play("fire");
    }
  }
}
