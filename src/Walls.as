package
{
  import org.flixel.*;

  public class Walls extends FlxGroup
  {
    [Embed(source='../data/walls.png')] private var WallMap:Class;

    public function Walls():void {
      var s:FlxSprite = new FlxSprite(16,0);
      s.loadGraphic(WallMap, true, true, 16, 16);
      add(s);
    }
  }
}
