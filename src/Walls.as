package
{
  import org.flixel.*;

  public class Walls extends FlxGroup
  {
    public static const BLOCKS:Number = 3;
    public static const WALL_HEIGHT:Number = 352;

    [Embed(source='../data/walls.png')] private var WallMap:Class;

    public var shockers:FlxGroup;

    private var _side:uint;
    private var _topY:Number;
    private var _offset:Number = 240;

    public function Walls(offset:Number = 240):void {
      shockers = new FlxGroup();

      _offset = offset;

      for(var i:uint = 1; i <= BLOCKS; i++) {
        var s:FlxSprite = new FlxSprite(0,FlxG.height - (WALL_HEIGHT*i) - _offset);
        s.loadGraphic(WallMap, true, true, 240, WALL_HEIGHT);
        add(s);
      }

      _topY = -((BLOCKS+1) * WALL_HEIGHT) + FlxG.height - _offset;
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
