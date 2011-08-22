package
{
  import org.flixel.*;

  public class MenuState extends FlxState
  {
    [Embed(source = "../data/title.png")] private var ImgTitle:Class;
    [Embed(source = "../data/music.swf", symbol='title')] private var TitleMusic:Class;
    [Embed(source = "../data/cursor.png")] private var ImgCursor:Class;

    override public function create():void {
      var title:FlxSprite = new FlxSprite(0,0);
      title.loadGraphic(ImgTitle, true, true, 240, 320);
      add(title);

      var t:FlxText = new FlxText(0,186,256, "PRESS ESCAPE");
      t.setFormat("ack");
      t.size = 16;
      t.alignment = "center";
      t.antialiasing = false;
      add(t);

      var button:FlxButton;
      button = new TwitterButton();
      add(button);

      button = new FacebookButton();
      add(button);

      FlxG.playMusic(TitleMusic);
      FlxG.mouse.load(ImgCursor, 2);
    }

    override public function update():void {
      if(!GameTracker.api)
          (GameTracker.api = FlxG.stage.addChild(new KongApi()) as KongApi).init();

      if(FlxG.keys.justPressed("ESCAPE")) {
        FlxG.music.fadeOut(1);
		    FlxG.switchState(new PlayState());
      }

      super.update();
    }
  }
}
