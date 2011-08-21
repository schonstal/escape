package
{
  import org.flixel.*;

  public class PlayerGlow extends FlxParticle
  {
    [Embed(source='../data/player_glow.png')] private var ImgPlayer:Class;
    public function PlayerGlow(X,Y):void {
      super(X,Y);
      loadGraphic(ImgPlayer, true, true, 16, 20);
      facing = (FlxG.state as PlayState).playerFacing;
    }
    
    override public function update():void {
      facing = (FlxG.state as PlayState).playerFacing;
      super.update();
    }
  }
}
