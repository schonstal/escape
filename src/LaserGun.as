package
{
  import org.flixel.*;

  public class LaserGun extends LaserPiece
  {
    [Embed(source='../data/laserGun.png')] private var ImgLaserGun:Class;
    [Embed(source='../data/sounds.swf', symbol='beep.wav')] private var BeepSound:Class;

    private var _wheelArcSize:Number = (32*Math.PI/16);

    public function LaserGun(X:Number, Y:Number, side:uint):void {
      super(X,Y);
      loadGraphic(ImgLaserGun, true, true, 32, 96);
      var atRest:Array = [0];
      var blinking:Array = [0,1,0,1,0,1,0,0,0,0,0,0];
      var moving:Array = [1,2,3,4];

      if(side == FlxObject.RIGHT) {
        for each(var a:Array in [atRest, blinking, moving]) {
          for (var i:int = 0; i < a.length; i++) {
            a[i] +=5;
          }
        }
      }

      addAnimation("atRest", atRest, 0);
      addAnimation("blinking", blinking, 20);
      addAnimation("moving", moving, 30);

      addAnimationCallback(function(id:String, frameNumber:uint, frameIndex:uint):void {
        if(id == "blinking" && frameIndex == 1) {
          FlxG.play(BeepSound,0.5);
        }
      });

      play("atRest");
    }

    override public function update():void {
      if(state == LaserGroup.STATE_BLINKING) {
        play("blinking");
      } else if (state == LaserGroup.STATE_MOVING) {
        play("moving");
        _curAnim.delay = -(_wheelArcSize / velocity.y);
      }
    }
  }
}
