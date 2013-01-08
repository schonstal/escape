package
{
  import org.flixel. *;

  public class LaserGroup extends FlxGroup
  {
    [Embed(source='data/sounds.swf', symbol='laser.wav')] private var LaserSound:Class;

    private var _pilot:PilotLaser;
    private var _laser:Laser;
    private var _gunLeft:LaserGun;
    private var _gunRight:LaserGun;

    private var _y:Number;
    private var _acceleration:FlxPoint;
    private var _velocity:FlxPoint;

    public var state:uint;
    public var stopped:Boolean = false;

    public function get y():Number { return _y; }
    public function set y(value:Number):void { 
      for each (var s:LaserPiece in members) {
        s.y += value - _y;
      }
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
      state = STATE_REST;
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

      _velocity = new FlxPoint(0,-19);
      _acceleration = new FlxPoint(0,-4);
      _y = _laser.y+8;
    }

    override public function update():void {
      if(state == STATE_MOVING) {
        if(!stopped) {
          for each (var s:LaserPiece in members) {
            s.acceleration.y = _acceleration.y;
            s.maxVelocity.y = 150;
            if(s.velocity.y == 0)
              s.velocity.y = velocity.y;
          }
        } else {
          for each (var l:LaserPiece in members) {
            l.acceleration.y = 0;
            l.maxVelocity.y = 0;
            l.velocity.y = 0;
          }
        }

        _y = _laser.y+8;

        if(_y > FlxG.camera.scroll.y + FlxG.height + 48) {
          y = FlxG.camera.scroll.y + FlxG.height + 47;
        }

        if(!_laser.visible) {
          FlxG.shake(0.01, 0.5);
          FlxG.play(LaserSound);
        }

        _laser.visible = true; 
      }

      if(state == STATE_BLINKING) {
        _pilot.play("blinking");
        if(_pilot.finished) {
          state = STATE_MOVING;
        }
      }

      super.update();
    }

    public function trigger():void {
      state = STATE_BLINKING;
    }

    public function stateCallback():uint {
      return state;
    }
  }
}
