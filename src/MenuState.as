package
{
  import org.flixel.*;

  public class MenuState extends FlxState
  {
    [Embed(source = "../data/title.png")] private var ImgTitle:Class;
    [Embed(source = "../data/music.swf", symbol='title')] private var TitleMusic:Class;
    [Embed(source = "../data/cursor.png")] private var ImgCursor:Class;

    private var _backgroundGroup:BackgroundGroup;

    private var _cameraVelocity:Number = 20;

    override public function create():void {
      _backgroundGroup = new BackgroundGroup();
      add(_backgroundGroup);

      var walls:Walls = new Walls(7500);
      add(walls);

      FlxG.camera.scroll.y = -8000;

      var title:FlxSprite = new FlxSprite(0,0);
      title.loadGraphic(ImgTitle, true, true, 240, 320);
      title.scrollFactor.x = title.scrollFactor.y = 0;
      add(title);

      var buttonGroup:ButtonGroup = new ButtonGroup();
      add(buttonGroup);

      var button:FlxButton = new StartButton(45,202);
      add(button);

      FlxG.playMusic(TitleMusic);
      FlxG.mouse.load(ImgCursor, 2);
    }

    override public function update():void {
      if(!GameTracker.api)
          (GameTracker.api = FlxG.stage.addChild(new KongApi()) as KongApi).init();

      FlxG.camera.scroll.y -= FlxG.elapsed * _cameraVelocity;

      super.update();
    }
  }
}
