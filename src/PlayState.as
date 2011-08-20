package
{
  import org.flixel.*;

  public class PlayState extends FlxState
  {
    override public function create():void {
      var t:FlxText = new FlxText(0,186,256, "You are playing.");
      t.alignment = "center";
      add(t);
      FlxG.flash(0xffffffff, 0.25);
    }

    override public function update():void {
      if(FlxG.keys.justPressed("ESCAPE")) {
        FlxG.flash(0xffffffff, 0.25);
      }
    }
  }
}
