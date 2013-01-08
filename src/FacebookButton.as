package
{
  import org.flixel.*;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;

  public class FacebookButton extends FlxButton
  {
    [Embed(source = "data/facebook.png")] private var ImgFacebook:Class;

    public function FacebookButton():void {
      super(FlxG.width-54,FlxG.height-22);

      loadGraphic(ImgFacebook, true, true, 32, 32);
      scale = new FlxPoint(0.5, 0.5);
      antialiasing = false;
      width = 16;
      height = 16;

      offset.x = 8;
      offset.y = 8;

      scrollFactor.x = scrollFactor.y = 0;
      
      onUp =  function():void { 
        FlxU.openURL("http://www.facebook.com/pages/escape/263886180307052");
      };
    }
  }
}
