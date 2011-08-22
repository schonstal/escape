package
{
  import org.flixel.*;

  public class MenuState extends FlxState
  {
    [Embed(source = "../data/title.png")] private var ImgTitle:Class;
    [Embed(source = "../data/music.swf", symbol='title')] private var TitleMusic:Class;
    override public function create():void {
      var title:FlxSprite = new FlxSprite(0,0);
      title.loadGraphic(ImgTitle, true, true, 240, 320);
      add(title);

      var t:FlxText = new FlxText(0,186,256, "PRESS ESCAPE");
      t.setFormat("ack");
      t.size = 20;
      t.alignment = "center";
      add(t);

      FlxG.playMusic(TitleMusic);
    }

    override public function update():void {
      if(FlxG.keys.justPressed("ESCAPE")) {
        FlxG.music.fadeOut(1);
		    FlxG.switchState(new PlayState());
      }
    }
  }
}
