package
{
  import org.flixel.*;

  public class Walls extends FlxGroup
  {
    public static const BLOCKS:Number = 30;
    public static const WALL_HEIGHT:Number = 128;

    [Embed(source='../data/walls.png')] private var WallMap:Class;

    public var shockers:FlxGroup;

    private var _side:uint;
    private var _topY:Number;

    public function Walls():void {
      shockers = new FlxGroup();

      for(var i:uint = 1; i <= BLOCKS; i++) {
        var s:FlxSprite = new FlxSprite(0,FlxG.height - (WALL_HEIGHT*i));
        s.loadGraphic(WallMap, true, true, 240, WALL_HEIGHT);
        add(s);
      }

      _topY = -((BLOCKS+1) * WALL_HEIGHT) + FlxG.height;
    }

    public override function update():void {
      members.sort(function(a:FlxSprite, b:FlxSprite):Boolean { return a.y > b.y; });
      for each (var s:FlxSprite in members) {
        if(s.y > FlxG.camera.scroll.y + FlxG.height) {
          s.y = _topY;

          _topY -= WALL_HEIGHT;
        }
      }
      super.update();
    }
  }
}
