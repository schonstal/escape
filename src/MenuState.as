package
{
  import org.flixel.*;

  public class MenuState extends FlxState
  {
    [Embed(source = "../data/title.png")] private var ImgTitle:Class;
    override public function create():void {
      var title:FlxSprite = new FlxSprite(0,0);
      title.loadGraphic(ImgTitle, true, true, 240, 320);
      add(title);

      var t:FlxText = new FlxText(0,186,256, "PRESS ESCAPE");
      t.alignment = "center";
      add(t);
    }

    override public function update():void {
      if(FlxG.keys.justPressed("ESCAPE")) {
		    FlxG.switchState(new PlayState());
      }
    }
  }
}
