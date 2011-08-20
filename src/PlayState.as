package
{
  import org.flixel.*;

  public class PlayState extends FlxState
  {
    private var _floor:FloorSprite;
    private var _player:Player;

    private var _scoreText:FlxText;
    private var _highScoreText:FlxText;

    private var _playerOffset:Number = 284;

    override public function create():void {
      _scoreText = new FlxText(0,186,256, GameTracker.score + "m");
      _scoreText.alignment = "center";
      add(_scoreText);

      _highScoreText = new FlxText(0,200,280, "High Score: 0");
      _highScoreText.alignment = "center";
      add(_highScoreText);

      _floor = new FloorSprite(0, _playerOffset + 20);
      add(_floor);

      _player = new Player(0,_playerOffset);
      add(_player);
    }

    override public function update():void {
      if(FlxG.keys.justPressed("ESCAPE")) {
        FlxG.flash(0xffffffff, 0.25);
      }
      FlxG.collide(_player,_floor);

      if(_player.y - _playerOffset < -GameTracker.score) {
        GameTracker.score = -(_player.y - _playerOffset);
        _scoreText.text = Math.floor(GameTracker.score/20) + "m";
        _highScoreText.text = "High Score: " + GameTracker.highScore + "m";
      }

      super.update();
    }
  }
}
