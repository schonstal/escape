package
{
  import org.flixel.*;

  public class PlayState extends FlxState
  {
    private var _floor:FloorSprite;
    private var _player:Player;

    private var _playerOffset:Number = 304;

    override public function create():void {
      var t:FlxText = new FlxText(0,186,256, "You are playing.");
      t.alignment = "center";
      add(t);

      _floor = new FloorSprite(0, _playerOffset);
      add(_floor);

      _player = new Player(0,0);
      add(_player);
    }

    override public function update():void {
      if(FlxG.keys.justPressed("ESCAPE")) {
        FlxG.flash(0xffffffff, 0.25);
      }
      FlxG.collide(_player,_floor);

      if(_player.y < -GameTracker.score) {
        GameTracker.score = -(_player.y - _playerOffset);
      }

      super.update();
    }
  }
}
