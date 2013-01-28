package
{
  import org.flixel.*;

  public class IncredibleApeButton extends FlxButton
  {
    [Embed(source = "data/logo.png")] private var ImgIncredibleApe:Class;

    public function IncredibleApeButton():void {
      super(38,FlxG.height-22);

      loadGraphic(ImgIncredibleApe, true, true, 99, 17);
      width = 99;
      height = 17;

      scrollFactor.x = scrollFactor.y = 0;
      
      onUp =  function():void { 
        FlxU.openURL("http://incredibleape.com/blog");
      };
    }
  }
}
