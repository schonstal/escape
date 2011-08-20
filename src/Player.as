package
{
  import org.flixel.*;

  public class Player extends FlxSprite
  {
    public var mobile:Boolean = true;

    [Embed(source='../data/player.png')] private var ImgPlayer:Class;
    private var _speed:FlxPoint;
    private var _gravity:Number = 600; 

    public function Player(X:Number,Y:Number):void {
      super(X,Y);
      loadGraphic(ImgPlayer, true, true, 16, 20); 

      //addAnimation("dance", [7, 8, 4, 2], _walkFPS);

      width = 16;
      height = 20;

      offset.x = 0;
      offset.y = 0;

      _speed = new FlxPoint();
      _speed.y = 400;
      _speed.x = 600;

      acceleration.y = _gravity;
      //maxVelocity.y = _gravity * 0.75;

      facing = RIGHT;
    }

    override public function update():void {           
      if(FlxG.keys.justPressed("ESCAPE")) {
        if(velocity.y < 0)
          velocity.y -= _speed.y;
        else
          velocity.y = -_speed.y;
        
        velocity.x = _speed.x * (facing == RIGHT ? -1 : 1); 
      }

      if(x <= PlayState.WALL_WIDTH && facing == RIGHT) {
        velocity.x = 0;
        facing = LEFT;
      } else if(x >= FlxG.camera.width - PlayState.WALL_WIDTH - width && facing == LEFT) {
        velocity.x = 0;
        facing = RIGHT;
      }

      if(velocity.y > _gravity * 0.75)
        velocity.y = _gravity * 0.75;

      if(!FlxG.keys.ESCAPE && velocity.y < 0)
        acceleration.y = _gravity * 3;
      else
        acceleration.y = _gravity;

      super.update();
    }
  }
}
