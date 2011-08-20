package
{
  import org.flixel.*;

  public class PlayState extends FlxState
  {
    private var _floor:FloorSprite;
    private var _player:Player;

    private var _scoreText:FlxText;
    private var _highScoreText:FlxText;
    private var _leftWalls:Walls;
    private var _rightWalls:Walls;

    private var _playerOffset:Number = 284;

    public static const WALL_WIDTH:Number = 32;

    override public function create():void {
      _scoreText = new FlxText(0,186,256, GameTracker.score + "m");
      _scoreText.alignment = "center";
      add(_scoreText);

      _highScoreText = new FlxText(0,200,280, "High Score: 0");
      _highScoreText.alignment = "center";
      add(_highScoreText);

      _floor = new FloorSprite(0, _playerOffset + 20);
      add(_floor);

      _leftWalls = new Walls(FlxObject.LEFT);
      add(_leftWalls);

      _rightWalls = new Walls(FlxObject.RIGHT);
      add(_rightWalls);

      _player = new Player(WALL_WIDTH,_playerOffset);
      add(_player);

      FlxG.camera.follow(_player);
      FlxG.camera.deadzone = new FlxRect(0,64,240,Number.MAX_VALUE);
    }

    override public function update():void {
      FlxG.collide(_player,_floor);

      //FlxG.camera.setBounds(0,-1000000000,0,-1000000000 + (_player.y - 320)) 

      if(_player.y - _playerOffset < -GameTracker.score) {
        GameTracker.score = -(_player.y - _playerOffset);
        _scoreText.text = Math.floor(GameTracker.score/20) + "m";
        _highScoreText.text = ""+FlxG.camera.y//"High Score: " + GameTracker.highScore + "m";
      }

      super.update();
    }
  }
}
