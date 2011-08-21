package
{
  import org.flixel.*;

  public class PlayState extends FlxState
  {
    public var debugText:FlxText;

    private var _floor:FloorSprite;
    private var _player:Player;

    private var _scoreText:FlxText;
    private var _highScoreText:FlxText;
    private var _gameOverText:FlxText;
    private var _gameOverPressText:FlxText;
    private var _pressEscapeText:FlxText;

    private var _leftWalls:Walls;
    private var _rightWalls:Walls;

    private var _leftShockers:ShockerGroup;
    private var _rightShockers:ShockerGroup;

    private var _glowGroup:FlxGroup;

    private var _sawCreated:Boolean = false;
    private var _saw:Saw;
    private var _sawY:Number = -100;
    
    private var _gameOver:Boolean = false;

    private var _playerOffset:Number = 284;

    private var _superModeTimer:Number = 0;
    private var _superModeThreshold:Number = 1;
    private var _superModeArray:Array = [0,0,0,0,0];
    private var _superMode:Boolean = false;

    public static const WALL_WIDTH:Number = 32;
    public static const GRAVITY:Number = 600; 
    public static const JUMP_SPEED_X:Number = 400;
    public static const JUMP_HEIGHT:Number = 400;
    public static const SAW_SPEED:Number = 3.5;
    public static const SAW_MAX:Number = 75;

    public function get player():Player {
      return _player;
    }

    override public function create():void {
      debugText = new FlxText(0,48,FlxG.width, "");
      debugText.alignment = "center";
      debugText.scrollFactor.x = debugText.scrollFactor.y = 0;
      add(debugText);

      _pressEscapeText = new FlxText(0,FlxG.height*(4/5),FlxG.width, "PRESS ESCAPE");
      _pressEscapeText.alignment = "center";
      add(_pressEscapeText);

      _leftWalls = new Walls();
      add(_leftWalls);

      _rightWalls = new Walls();
      add(_rightWalls);

      _leftShockers = new ShockerGroup(FlxObject.LEFT);
      add(_leftShockers);

      _rightShockers = new ShockerGroup(FlxObject.RIGHT);
      add(_rightShockers);

      _floor = new FloorSprite(0, _playerOffset + 20);
      add(_floor);

      _glowGroup = new FlxGroup();
      _glowGroup.maxSize = 30;
      add(_glowGroup);

      _player = new Player(WALL_WIDTH,_playerOffset);
      _player.jumpCallback = createGlow;
      add(_player);

      _scoreText = new FlxText(0,16,FlxG.width, GameTracker.score + "m");
      _scoreText.alignment = "center";
      _scoreText.scrollFactor.x = _scoreText.scrollFactor.y = 0;
      add(_scoreText);


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

      if(!_gameOver && _sawCreated && _saw.y < _player.y + _player.height) {
        die();
      }

      if(_player.x <= WALL_WIDTH) {
        checkShocked(_leftShockers);
        _player.x = WALL_WIDTH;
      } else if(_player.x >= FlxG.width - WALL_WIDTH - _player.width) {
        checkShocked(_rightShockers);
        _player.x = FlxG.width - WALL_WIDTH - _player.width;
      }

      _superModeTimer += FlxG.elapsed;
      if(_superModeTimer > _superModeThreshold) {
        _superModeTimer = 0;
        _superModeArray.shift();
        _superModeArray.push(GameTracker.score);
        if(Math.abs(GameTracker.score - _superModeArray[0]) > 36) {
          _superMode = true;
        } else {
          _superMode = false;
        }
      }
      if (_superMode && !_gameOver && !_player.shocked) {
        createGlow();
      }

      if(FlxG.collide(_player, _leftShockers) || FlxG.overlap(_player, _rightShockers)) {
        _player.shocked = true;
      }

      if(_player.y - _playerOffset < -GameTracker.score*20) {
        GameTracker.score = -(_player.y - _playerOffset)/20;
        _scoreText.text = Math.floor(GameTracker.score) + "m";
      }

      if(_gameOver && FlxG.keys.justPressed("ESCAPE")) {
        FlxG.fade(0xff000000, 0.5, function():void { 
          FlxG.switchState(new PlayState()); 
          GameTracker.score = 0; 
        });
      }

      super.update();
    }

    public function createGlow(alphaRate:Number = 0.75):void {
      var glow:PlayerGlow = _glowGroup.recycle(PlayerGlow) as PlayerGlow;
      glow.x = _player.x;
      glow.y = _player.y;
      glow.alpha = 0.5;
      glow.facing = _player.facing;
      glow.alphaRate = alphaRate;
      glow.play(_player.animation);
    }

    private function checkShocked(group:ShockerGroup):void {
      for each (var shocker:Shocker in group.members) {
        if(_player.y > shocker.y - _player.height+1 && _player.y < shocker.y + shocker.height-2) {
          _player.shocked = true;
        }
      }
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
