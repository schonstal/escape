package
{
  import org.flixel.*;

  public class BackgroundGroup extends FlxGroup
  {
    [Embed(source='../data/startZone.png')] private var ImgStartZone:Class;
    [Embed(source='../data/bg1.png')] private var ImgBg1:Class;
    [Embed(source='../data/bg2.png')] private var ImgBg2:Class;
    [Embed(source='../data/sky.png')] private var ImgSky:Class;

    public function BackgroundGroup():void {
      var s:FlxSprite;

      s = new FlxSprite(0,-320);
      s.loadGraphic(ImgSky, true, true, 240, 640);
      s.scrollFactor.y = 0.01;
      add(s);

      s = new FlxSprite(0,-320);
      s.loadGraphic(ImgBg2, true, true, 240, 640);
      s.scrollFactor.y = 0.15;
      add(s);

      s = new FlxSprite(0,80);
      s.loadGraphic(ImgStartZone, true, true, 240, 224);
      add(s);

      s = new FlxSprite(0, -2320);
      s.loadGraphic(ImgBg1, true, true, 240, 2400);
      add(s);
    }
  }
}
