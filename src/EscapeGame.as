package
{
  import org.flixel.*;
  import com.teamclew.*;
  
  [SWF(width="480", height="640", backgroundColor="#000000")]
//  [Frame(factoryClass="Preloader")]

  public class EscapeGame extends TCGame
  {
    [Embed(source = 'data/Adore64.ttf', fontFamily="ack", embedAsCFF="false")] public var AckFont:String;
	
    public function EscapeGame() {
      FlxG.level = 0;
      super(240,320,MenuState,1,60,30,false);
    }
  }
}
