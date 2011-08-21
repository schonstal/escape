package
{
  import org.flixel.*;

  public class PlayState extends FlxState
  {
    private var _floor:FloorSprite;
    private var _player:Player;

    private var _scoreText:FlxText;
    private var _highScoreText:FlxText;
    private var _gameOverText:FlxText;
    private var _gameOverPressText:FlxText;
    private var _pressEscapeText:FlxText;

    private var _debugText:FlxText;

    private var _leftWalls:Walls;
    private var _rightWalls:Walls;

    private var _sawCreated:Boolean = false;
    private var _saw:Saw;
    private var _sawY:Number = -100;
    
    private var _gameOver:Boolean = false;

    private var _playerOffset:Number = 284;

    public static const WALL_WIDTH:Number = 32;
    public static const GRAVITY:Number = 600; 

    override public function create():void {
      _scoreText = new FlxText(0,16,FlxG.width, GameTracker.score + "m");
      _scoreText.alignment = "center";
      _scoreText.scrollFactor.x = _scoreText.scrollFactor.y = 0;
      add(_scoreText);

      _debugText = new FlxText(0,48,FlxG.width, "");
      _debugText.alignment = "center";
      _debugText.scrollFactor.x = _debugText.scrollFactor.y = 0;
      add(_debugText);

      _pressEscapeText = new FlxText(0,FlxG.height*(4/5),FlxG.width, "PRESS ESCAPE");
      _pressEscapeText.alignment = "center";
      add(_pressEscapeText);

      _floor = new FloorSprite(0, _playerOffset + 20);
      add(_floor);

      _leftWalls = new Walls(FlxObject.LEFT);
      add(_leftWalls);

      _rightWalls = new Walls(FlxObject.RIGHT);
      add(_rightWalls);

      _player = new Player(WALL_WIDTH,_playerOffset);
      add(_player);

      FlxG.camera.follow(_player);
      FlxG.camera.deadzone = new FlxRect(0,FlxG.height*(2/5),240,Number.MAX_VALUE);
    }

    override public function update():void {
      if(FlxG.collide(_player,_floor))
        _player.standing = true;
      else
        _player.standing = false;

      //FlxG.camera.setBounds(0,-1000000000,0,-1000000000 + (_player.y - 320)) 

      if(!_sawCreated && FlxG.camera.scroll.y < _sawY) {
        _saw = new Saw(0, FlxG.height);
        add(_saw);
        _sawCreated = true;
      }

      if(_sawCreated)
        _debugText.text = "" + Math.floor(_saw.y) + " : " + Math.floor(_player.y);

      if(!_gameOver && _sawCreated && _saw.y < _player.y + _player.height) {
        die();
      }

      if(_player.y - _playerOffset < -GameTracker.score) {
        GameTracker.score = -(_player.y - _playerOffset);
        _scoreText.text = Math.floor(GameTracker.score/20) + "m";
      }

      if(_gameOver && FlxG.keys.justPressed("ESCAPE")) {
        FlxG.fade(0xff000000, 0.5, function():void { 
          FlxG.switchState(new PlayState()); 
          GameTracker.score = 0; 
        });
      }

      super.update();
    }

    private function die():void {
      //var emitter:FlxEmitter = new FlxEmitter(_player.x, _player.y, 6);
      //emitter.bounce = 1;
      //emitter.gravity = GRAVITY;
      //add(emitter);
      //emitter.start(true, 0, 0.01, 6);
      FlxG.shake(0.005, 0.05);
      remove(_player);

      _gameOverText = new FlxText(0,FlxG.height/5,FlxG.width, "GAME OVER");
      _gameOverText.alignment = "center";
      _gameOverText.size = 32;
      _gameOverText.scrollFactor.x = _gameOverText.scrollFactor.y = 0;
      add(_gameOverText);

      _gameOverPressText = new FlxText(0,FlxG.height/5+32,FlxG.width, "PRESS ESCAPE TO CONTINUE");
      _gameOverPressText.alignment = "center";
      _gameOverPressText.scrollFactor.x = _gameOverPressText.scrollFactor.y = 0;
      add(_gameOverPressText);

      _gameOver = true;
    }
  }
}
