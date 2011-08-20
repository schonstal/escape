package
{
  import org.flixel.*;

  public class Player extends FlxSprite
  {
    public var mobile:Boolean = true;

    [Embed(source='../data/player.png')] private var ImgPlayer:Class;
    private var _speed:Number = 400;
    private var _gravity:Number = 600; 

    public function Player(X:Number,Y:Number):void {
      super(X,Y);
      loadGraphic(ImgPlayer, true, true, 16, 20); 

      //addAnimation("dance", [7, 8, 4, 2], _walkFPS);

      width = 16;
      height = 20;

      offset.x = 0;
      offset.y = 0;

      acceleration.y = _gravity;
      //maxVelocity.y = _gravity * 0.75;

      facing = RIGHT;
    }

    override public function update():void {           
      if(FlxG.keys.justPressed("ESCAPE")) {
        if(velocity.y < 0)
          velocity.y -= _speed;
        else
          velocity.y = -_speed;
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
