package
{
  import org.flixel.*;

  public class LaserPiece extends FlxSprite
  {
    public var getState:Function;

    public function LaserPiece(X:Number, Y:Number):void {
      super(X,Y);
    }

    public function get state():uint {
      return getState();
    }
  }
}
