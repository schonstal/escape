package
{
  import org.flixel.*;

  public class PilotLaser extends LaserPiece
  {
    [Embed(source='data/pilotLaser.png')] private var ImgPilotLaser:Class;

    public function PilotLaser(X:Number, Y:Number):void {
      super(X,Y);
      loadGraphic(ImgPilotLaser, true, true, 240, 1);
      addAnimation("on", [0]);
      addAnimation("off", [1]);
      addAnimation("blinking", [1,0,1,0,1,0,1,1,1,1,1,1], 20);
      blend = "add";
      alpha = 0.3;

      play("on");
    }

    override public function update():void {
      if(state == LaserGroup.STATE_MOVING) {
        play("off");
      }
    }
  }
}
