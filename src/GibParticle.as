package
{
  import org.flixel.*;

  public class GibParticle extends FlxParticle
  {
    [Embed(source='../data/gibs.png')] private var ImgGibs:Class;
    public var onEmitCallback:Function;

    public function GibParticle():void {
      loadGraphic(ImgGibs, true, true, 8, 8);
      exists = false;
      antialiasing = false;
      frame = Math.floor((Math.abs(Math.random()) * 5) - 0.0001);
    }

    override public function onEmit():void {
      if(onEmitCallback != null) 
        onEmitCallback();
    }
  }
}
