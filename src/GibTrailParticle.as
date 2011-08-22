package
{
  import org.flixel.*;

  public class GibTrailParticle extends FlxParticle
  {
    public var fadeRate:Number = 1;

    public function GibTrailParticle():void {
      makeGraphic(1, 1, 0xff7e0fff);
      exists = false;
      antialiasing = false;
      blend = "add";
    }

    override public function update():void {
      alpha -= FlxG.elapsed / fadeRate;
      super.update();
    }
  }
}
