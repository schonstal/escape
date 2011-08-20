package
{
  import org.flixel.*;

  public class Saw extends FlxSprite
  {
    [Embed(source='../data/saw.png')] private var ImgSaw:Class;

    private var _heightOffset:Number = 16;

    public function Saw(X:Number, Y:Number):void {
      super(X,Y);
      loadGraphic(ImgSaw, true, true, 240, 160);
      velocity.y = -10;
      maxVelocity.y = 75;
    }

    override public function update():void {
      if(y > FlxG.camera.scroll.y + FlxG.height + _heightOffset) {
        y = FlxG.camera.scroll.y + FlxG.height + _heightOffset - 1;
      }
      super.update();
    }
  }
}
