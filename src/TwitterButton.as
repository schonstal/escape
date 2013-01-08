package
{
  import org.flixel.*;
  import flash.net.URLRequest;
  import flash.net.navigateToURL;

  public class TwitterButton extends FlxButton
  {
    [Embed(source = "data/twitter.png")] private var ImgTwitter:Class;

    private var _score:Number;

    public function TwitterButton(score:Number = 0):void {
      super(FlxG.width - 74, FlxG.height - 22);

      _score = score;

      scrollFactor.x = scrollFactor.y = 0;

      loadGraphic(ImgTwitter, true, true, 32, 32);
      scale = new FlxPoint(0.5, 0.5);
      antialiasing = false;
      width = 16;
      height = 16;

      offset.x = offset.y = 8;
      
      onUp =  function():void {
		var aScore:Number = GameTracker.score; 
		aScore = Math.floor(aScore);
		trace(aScore);
		
        FlxU.openURL("https://twitter.com/intent/tweet?source=webclient&text=" +
          (aScore == 0 ? "I'm%20playing" : "I%20ascended%20" + aScore + "%20meters%20in") +
          "%20%2FESCAPE%5C!");
		  
//		          FlxU.openURL("https://twitter.com/intent/tweet?source=webclient&text=" +
//          (aScore == 0 ? "I'm%20playing" : "I%20ascended%20" + aScore + "%20meters%20in") +
//          "%20%2FESCAPE%5C%20on%20Kongregate!&url=http%3A%2F%2Fkon.gg%2FohZ4iO");			
      };
    }
  }
}
