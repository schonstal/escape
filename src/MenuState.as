package
{
  import org.flixel.*;

  public class MenuState extends FlxState
  {
    override public function create():void {
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
