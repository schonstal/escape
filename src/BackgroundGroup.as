package
{
  import org.flixel.*;

  public class BackgroundGroup extends FlxGroup
  {
    [Embed(source='../data/startZone.png')] private var ImgStartZone:Class;

    public function BackgroundGroup():void {
      var startZoneSprite:FlxSprite = new FlxSprite(0,80);
      startZoneSprite.loadGraphic(ImgStartZone, true, true, 240, 224);
      add(startZoneSprite);
    }
  }
}
