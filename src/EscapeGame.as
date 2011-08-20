package
{
  import org.flixel.*;
  [SWF(width="480", height="640", backgroundColor="#000000")]
  [Frame(factoryClass="Preloader")]

  public class EscapeGame extends FlxGame
  {
    public function EscapeGame() {
      FlxG.level = 0;
      super(240,320,MenuState,2);
    }
  }
}
