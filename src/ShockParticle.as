package
{
  import org.flixel.*;

  public class ShockParticle extends FlxParticle
  {
    [Embed(source='../data/spark.png')] private var ImgSpark:Class;

    public var fadeRate:Number = 1;

    public function ShockParticle():void {
      loadGraphic(ImgSpark, true, true, 3, 3);
      exists = false;
      antialiasing = false;
      blend = "add";
      angularVelocity = 0;
    }

    override public function update():void {
      angularVelocity = 0;
      angle = 0;
      alpha -= FlxG.elapsed / fadeRate;
      super.update();
    }
  }
}
