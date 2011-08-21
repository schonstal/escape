package
{
  import org.flixel.*;

  public class Walls extends FlxGroup
  {
    public static const BLOCKS:Number = 200;
    [Embed(source='../data/walls.png')] private var WallMap:Class;

    private var _topY:Number;

    public function Walls(side:uint):void {
      for(var i:uint = 1; i <= BLOCKS; i++) {
        var s:FlxSprite = new FlxSprite((side == FlxObject.LEFT ? 16 : FlxG.width - 32),FlxG.height - (16*i));
        s.loadGraphic(WallMap, true, true, 16, 16);
        if(side == FlxObject.RIGHT)
          s.facing = FlxObject.LEFT;
        add(s);
      }

      _topY = -((BLOCKS+1) * 16) + FlxG.height;
    }

    public override function update():void {
      members.sort(function(a:FlxSprite, b:FlxSprite):Boolean { return a.y > b.y; });
      for each (var s:FlxSprite in members) {
        if(s.y > FlxG.camera.scroll.y + FlxG.height) {
          s.y = _topY;
          _topY -= 16;
        }
      }
      super.update();
    }
  }
}
