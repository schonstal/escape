package
{
  import org.flixel.*;

  public class Shocker extends FlxSprite
  {
    [Embed(source='../data/shocker.png')] private var ImgShocker:Class;
    public var side:uint;

    public function Shocker():void {
      super(0,0);
      loadGraphic(ImgShocker, true, true, 36, 16);
      addAnimation("left", [0]);
      addAnimation("right", [1]);

      width = 36;
      height = 16;
    }

    override public function update():void {
      if(side == LEFT)
        play("left");
      else
        play("right"); 
      super.update();
    }
  }
}
