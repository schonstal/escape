package
{
  import org.flixel.*;

  public class PlayState extends FlxState
  {
    [Embed(source='../data/sounds.swf', symbol='shock.wav')] private var ShockSound:Class;
    [Embed(source='../data/sounds.swf', symbol='death.wav')] private var DeathSound:Class;
    [Embed(source='../data/music.swf', symbol='play')] private var PlayMusic:Class;

    public var debugText:FlxText;

    private var _floor:FloorSprite;
    private var _player:Player;

    private var _scoreText:FlxText;
    private var _highScoreText:FlxText;

    private var _leftWalls:Walls;
    private var _rightWalls:Walls;

    private var _leftShockers:ShockerGroup;
    private var _rightShockers:ShockerGroup;

    private var _glowGroup:FlxGroup;
    private var _sparksEmitter:FlxEmitter;

    private var _laserCreated:Boolean = false;
    private var _laserGroup:LaserGroup;
    
    private var _gameOver:Boolean = false;

    private var _playerOffset:Number = 284;

    private var _backgroundGroup:BackgroundGroup;
    
    private var _bottomlessBounds:FlxRect;
    private var _bottomedBounds:FlxRect;

    public static const WALL_WIDTH:Number = 32;
    public static const GRAVITY:Number = 600; 
    public static const JUMP_SPEED_X:Number = 400;
    public static const JUMP_HEIGHT:Number = 400;
    public static const SAW_SPEED:Number = 3.5;
    public static const SAW_MAX:Number = 75;
    public static const SUPER_MODE_DISTANCE:Number = 38;

    public function get player():Player {
      return _player;
    }

    override public function create():void {
      FlxG.mouse.hide();
      FlxG.camera.scroll.y = -16;

      _backgroundGroup = new BackgroundGroup();
      add(_backgroundGroup);

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
      _player.fallCallback = createSparks;
      add(_player);

      _laserGroup = new LaserGroup();
      add(_laserGroup);

      _scoreText = new FlxText(0,16,FlxG.width, GameTracker.score + "m");
      _scoreText.alignment = "center";
      _scoreText.setFormat("ack");
      _scoreText.scrollFactor.x = _scoreText.scrollFactor.y = 0;
      _scoreText.shadow = 0xff000000;
      add(_scoreText);

      _bottomlessBounds = new FlxRect(0,FlxG.height/2,240,Number.MAX_VALUE);
      _bottomedBounds = new FlxRect(0,FlxG.height/2,240,FlxG.height/2);

      FlxG.camera.follow(_player);
      FlxG.camera.deadzone = _bottomedBounds;
    }

    override public function update():void {
      if(!_gameOver) {
        if(FlxG.collide(_player,_floor))
          _player.standing = true;
        else
          _player.standing = false;

        //FlxG.camera.setBounds(0,-1000000000,0,-1000000000 + (_player.y - 320)) 

        if(_laserGroup.state == LaserGroup.STATE_REST && _player.y <= 46) {
          _laserGroup.trigger();
          _backgroundGroup.troll.play("trolololo");
        }

        if(_player.exists) {
          if(_player.y > _laserGroup.y)
            _laserGroup.stopped = true;
          else
            _laserGroup.stopped = false;
        }

        if(_laserGroup.state == LaserGroup.STATE_MOVING) {
          if(!GameTracker.playedMusic) {
            FlxG.playMusic(PlayMusic);
            GameTracker.playedMusic = true;
          }
          if(FlxG.camera.deadzone.height < Number.MAX_VALUE && _player.y < _laserGroup.y)
            FlxG.camera.deadzone = _bottomlessBounds;
        }

        if(!_gameOver && _laserGroup.stateCallback() == LaserGroup.STATE_MOVING && _laserGroup.y < _player.y + _player.height && _player.y < _laserGroup.y + 8) {
          die();
        }

        if(_player.x <= WALL_WIDTH) {
          checkShocked(_leftShockers);
          _player.x = WALL_WIDTH;
        } else if(_player.x >= FlxG.width - WALL_WIDTH - _player.width) {
          checkShocked(_rightShockers);
          _player.x = FlxG.width - WALL_WIDTH - _player.width;
        }

        if (_player.superMode && !_gameOver && !_player.shocked) {
          createGlow();
        }

        if(FlxG.collide(_player, _leftShockers) || FlxG.overlap(_player, _rightShockers)) {
          _player.shocked = true;
        }

        if(_player.y - _playerOffset < -GameTracker.score*20) {
          GameTracker.score = -(_player.y - _playerOffset)/20;
          _scoreText.text = Math.floor(GameTracker.score) + "m";
        }

      } 
      if(_gameOver && GameTracker.escapePressed()) {
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

    public function createSparks():void {
      _sparksEmitter = new FlxEmitter();
      for(var i:int = 0; i < 10; i++) {
        var particle:ShockParticle = new ShockParticle();
        _sparksEmitter.add(particle);
      }
      _sparksEmitter.at(_player) 
      _sparksEmitter.gravity = GRAVITY*0.8;
      if(_player.x < FlxG.width/2)
        _sparksEmitter.setXSpeed(50,200);
      else
        _sparksEmitter.setXSpeed(-200,-50);

      _sparksEmitter.setYSpeed(-200,-80);
    //  emitter.particleClass = ShockParticle;
      add(_sparksEmitter);
      _sparksEmitter.start();
    }

    private function checkShocked(group:ShockerGroup):void {
      if(!_player.shocked) {
        for each (var shocker:Shocker in group.members) {
          if(_player.y > shocker.y - _player.height+2 && _player.y < shocker.y + shocker.height-3) {
            _player.shocked = true;
            FlxG.play(ShockSound);
            break;
          }
        }
      }
    }

    private function die():void {
      _gameOver = true;
      FlxG.play(DeathSound);

      var emitter:FlxEmitter = new FlxEmitter();
      for(var i:int = 0; i < 10; i++) {
        var p:GibParticle = new GibParticle();
        emitter.add(p);
      }
      emitter.bounce = 1;
      emitter.gravity = GRAVITY;
      emitter.at(_player);
      add(emitter);
      emitter.start();
      emitter.setYSpeed(-400, -200);
      FlxG.shake(0.005, 0.05);
      _player.exists = false;

      var gameOverGroup:GameOverGroup = new GameOverGroup();
      add(gameOverGroup);

      remove(_player);
      remove(_scoreText);

      FlxG.mouse.show();

      GameTracker.api.kongregate.stats.submit("max_height", GameTracker.score);
    }
  }
}
