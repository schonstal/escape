package
{
  import org.flixel.*;

  public class ShockerGroup extends FlxGroup
  {
    public static const SHOCKER_WIDTH:Number = 20;

    private var _side:uint;
    private var _topY:Number;

    private var _clusterMin:Number = 2;
    private var _clusterMax:Number = 3;

    private var _probability:Number = 0.01;
    private var _prevY:Number = 0;

    private var _seed:Number = 12345;

    public function ShockerGroup(side:uint):void {
      _side = side;
      maxSize = 50;

      _topY = 0;
      _seed += FlxG.elapsed + side;
    }

    public override function update():void {
      // TODO: Change difficulty progression
      if(GameTracker.score > 1000) {
        _probability = 0.015;
      } else if(GameTracker.score > 600) {
        _clusterMax = 5;
      } else if(GameTracker.score > 400) {
        _clusterMin = 3;
      } else if(GameTracker.score > 200) {
        _clusterMax = 4;
      }

      if(FlxG.camera.scroll.y < _topY) {
        _topY = FlxG.camera.scroll.y;
      }

      if(FlxG.camera.scroll.y < _prevY) {
        _prevY = FlxG.camera.scroll.y;

        var randNum:Number = Math.abs(FlxU.srand(_seed)); 
        _seed += randNum;
        if(randNum < _probability) {
          var amt:Number = Math.abs(FlxU.srand(_seed));
          _seed += amt;
          amt *= _clusterMax;
          if(amt < _clusterMin)
            amt = _clusterMin;

          for(var i:int = 0; i < amt; i++) {
            var s:Shocker = recycle(Shocker) as Shocker;
            s.x = (_side == FlxObject.LEFT ? 16 : FlxG.width - SHOCKER_WIDTH - 16);
            s.y = _topY - 16;
            s.side = _side;

            _topY -= 16
          }

          _topY -= 64;
        }
      }

      super.update();
    }
  }
}
