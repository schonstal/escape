package
{
  import org.flixel.*;

  public class ShockParticle extends FlxParticle
  {
    public var fadeRate:Number = 1;

    public function ShockParticle():void {
      makeGraphic(1, 1, 0xffAAFFFF);
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
