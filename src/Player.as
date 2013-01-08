package
{
  import org.flixel.*;

  public class Player extends FlxSprite
  {
    public var mobile:Boolean = true;
    public var standing:Boolean = true;
    public static const WALL_LEEWAY:Number = 24;

    [Embed(source='data/sounds.swf', symbol='jump.wav')] private var JumpSound:Class;
    [Embed(source='data/sounds.swf', symbol='superJump.wav')] private var SuperJumpSound:Class;
    [Embed(source='data/sounds.swf', symbol='shockFall.wav')] private var ShockFallSound:Class;

    [Embed(source='data/player.png')] private var ImgPlayer:Class;
    private var _speed:FlxPoint;
    private var _gravity:Number = PlayState.GRAVITY; 

    private var _leftWallRange:Number;
    private var _rightWallRange:Number;
    private var _escapePressed:Boolean = false;

    private var _maxCameraY:Number = 0;

    private var _shockTimer:Number = 0;
    private var _shockThreshold:Number = 0.5;

    private var _alreadyFell:Boolean = false;

    public var shocked:Boolean = false;
    public var animation:String = "";

    public var jumpCallback:Function = null;
    public var fallCallback:Function = null;
    public var superMode:Boolean = false;

    public function Player(X:Number,Y:Number):void {
      super(X,Y);
      loadGraphic(ImgPlayer, true, true, 16, 20); 

      //addAnimation("dance", [7, 8, 4, 2], _walkFPS);

      width = 16;
      height = 20;

      offset.x = 0;
      offset.y = 0;

      _speed = new FlxPoint();
      _speed.y = PlayState.JUMP_HEIGHT;
      _speed.x = PlayState.JUMP_SPEED_X;

      acceleration.y = _gravity;
      //maxVelocity.y = _gravity * 0.75;
      addAnimation("slide", [5]);
      addAnimation("jump", [3]);
      addAnimation("fall", [4]);
      addAnimation("idle", [0,2,0,2,0,2,0,2,0,2,1,2],4);
      addAnimation("shock", [7,6],15);
      addAnimation("crisp", [6]);


      facing = RIGHT;

      maxVelocity.y = 600;
    }

    override public function play(animationName:String, force:Boolean = false):void {
      animation = animationName;
      super.play(animationName, force);
    }

    override public function update():void {           
      _leftWallRange = PlayState.WALL_WIDTH;
      _rightWallRange = (FlxG.camera.width - PlayState.WALL_WIDTH) - width;

      if(shocked) {
        _shockTimer += FlxG.elapsed;
        if(_shockTimer < _shockThreshold) {
          FlxG.shake(0.005, 0.05);
          velocity.y = velocity.x = acceleration.x = acceleration.y = 0;
          play("shock");
        } else {
          if(!_alreadyFell) {
            FlxG.play(ShockFallSound, 0.8);
            FlxG.shake(0.02, 0.2);
            FlxG.flash(0xffeeeeff, 0.1);
            if(fallCallback != null) {
              fallCallback();
            }
            _alreadyFell = true;
          }
          angularVelocity = (x < FlxG.width/2 ? 100 : -100);
          play("crisp");
          acceleration.y = _gravity;
          velocity.x = (x < FlxG.width/2 ? 100 : -100);
        }
      } else {
        if(GameTracker.escapePressed() && (x <= _leftWallRange + WALL_LEEWAY || x >= _rightWallRange - WALL_LEEWAY)) {
          _escapePressed = true;
        }

        if(_escapePressed && velocity.x == 0) {
          if(velocity.y < 0) {
            superMode = true;
            FlxG.play(SuperJumpSound);
            velocity.y -= _speed.y;
          } else {
            velocity.y = -_speed.y;
            FlxG.play(JumpSound);
            superMode = false;
          }
          
          velocity.x = _speed.x * (facing == LEFT ? -1 : 1);
          _escapePressed = false; 

          if(jumpCallback != null) {
            for(var i:int = 0; i < 2; i++) {
              jumpCallback(1);
            }
          }
        }


        if(x <= _leftWallRange && facing == LEFT) {
          velocity.x = 0;
          x = PlayState.WALL_WIDTH;
          facing = RIGHT;
        } else if(x >= _rightWallRange && facing == RIGHT) {
          velocity.x = 0;
          x = (FlxG.camera.width - PlayState.WALL_WIDTH) - width;
          facing = LEFT;
        }

      if(velocity.y > _gravity * 0.75)
        velocity.y = _gravity * 0.75;

        if(!GameTracker.escapeHeld() && velocity.y < 0)
          acceleration.y = _gravity * 3;
        else
          acceleration.y = _gravity;

        if(standing) {
          play("idle");
        } else {
          if(velocity.x == 0)
            play("slide");
          else if (velocity.y < 0)
            play("jump");
          else
            play("fall");
        }
      }

      super.update();
    }
  }
}
