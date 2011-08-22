package
{
  import org.flixel.*;
  [SWF(width="480", height="640", backgroundColor="#000000")]
  [Frame(factoryClass="Preloader")]

  public class EscapeGame extends FlxGame
  {
    [Embed(source = '../data/acknowtt.ttf', fontFamily="ack", embedAsCFF="false")] public var AckFont:String;
    public function EscapeGame() {
      FlxG.level = 0;
      super(240,320,MenuState,2);
    }
  }
}
