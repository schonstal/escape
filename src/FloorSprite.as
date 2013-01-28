package
{
  import org.flixel.*;

  public class FloorSprite extends FlxSprite
  {
    [Embed(source = 'data/floor.png')] private var ImgFloor:Class;
    public function FloorSprite(X:Number, Y:Number) {
      super(X,Y);
      loadGraphic(ImgFloor, true, true, 240, 16);
      immovable = true;
    }
  }
}
