package
{
  import org.flixel.*;

  public class ButtonGroup extends FlxGroup
  {
    public function ButtonGroup():void {
      var button:FlxButton;
      button = new TwitterButton();
      add(button);

      button = new FacebookButton();
      add(button);

      //button = new IncredibleApeButton();
      //add(button);
    }
  }
}
