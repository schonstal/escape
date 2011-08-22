package
{
  import org.flixel. *;

  public class LaserGroup extends FlxGroup
  {
    private var _state:uint;
    private var _pilot:PilotLaser;
    private var _laser:Laser;
    private var _gunLeft:LaserGun;
    private var _gunRight:LaserGun;

    private var _y:Number;
    private var _acceleration:FlxPoint;
    private var _velocity:FlxPoint;

    public function get y():Number { return _y; }
    public function set y(value:Number):void { 
      _y = value;
    }

    public function get acceleration():FlxPoint { return _acceleration; }
    public function set acceleration(value:FlxPoint):void {
      _acceleration = value;
    }

    public function get velocity():FlxPoint { return _velocity; }
    public function set velocity(value:FlxPoint):void {
      _velocity = value;
    }

    public static const STATE_REST:uint = 0;
    public static const STATE_BLINKING:uint = 1;
    public static const STATE_MOVING:uint = 2;

    public function LaserGroup() {
      _state = STATE_REST;
      _laser = new Laser(0,16);
      add(_laser);
      _pilot = new PilotLaser(0,46);
      add(_pilot);
      _gunLeft = new LaserGun(0,-16,FlxObject.LEFT);
      add(_gunLeft);
      _gunRight = new LaserGun(FlxG.width-32,-16,FlxObject.RIGHT);
      add(_gunRight);

      for each (var s:LaserPiece in members) {
        s.getState = stateCallback;
      }
    }

    override public function update():void {
      /*for each (var s:LaserPiece in members) {
        s.velocity = _velocity;
        s.acceleration = _acceleration;
      }*/

      super.update();
    }

    public function stateCallback():uint {
      return _state;
    }
  }
}
