package
{
  import org.flixel.*;

  public class PlayerGlow extends FlxSprite
  {
    public var alphaRate:Number = 0.75;
    public var ttl:Number = 1;

    [Embed(source='data/player_glow.png')] private var ImgPlayer:Class;
    public function PlayerGlow():void {
      loadGraphic(ImgPlayer, true, true, 16, 20);
      blend = "add";

      addAnimation("slide", [5]);
      addAnimation("jump", [3]);
      addAnimation("fall", [4]);
      addAnimation("idle", [0,2,0,2,0,2,0,2,0,2,1,2],4);
      addAnimation("shock", [7,6],15);
      addAnimation("crisp", [6]);
    }
    
    override public function update():void {
      alpha -= FlxG.elapsed / alphaRate;
      ttl -= FlxG.elapsed;
      super.update();
    }
  }
}
