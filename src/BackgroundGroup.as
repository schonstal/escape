package
{
  import org.flixel.*;

  public class BackgroundGroup extends FlxGroup
  {
    [Embed(source='data/startZone.png')] private var ImgStartZone:Class;
    [Embed(source='data/bg1.png')] private var ImgBg1:Class;
    [Embed(source='data/bg2.png')] private var ImgBg2:Class;
    [Embed(source='data/bg3.png')] private var ImgBg3:Class;
    [Embed(source='data/bg4.png')] private var ImgBg4:Class;
    [Embed(source='data/sky.png')] private var ImgSky:Class;

    public var troll:FlxSprite;

    public function BackgroundGroup():void {
      var s:FlxSprite;

      s = new FlxSprite(0,-1320);
      s.loadGraphic(ImgSky, true, true, 240, 1600);
      s.scrollFactor.y = 0.033;
      add(s);

      s = new FlxSprite(0,28);
      s.loadGraphic(ImgBg4, true, true, 240, 320);
      s.scrollFactor.y = 0.055;
      add(s);

      s = new FlxSprite(0,-150);
      s.loadGraphic(ImgBg3, true, true, 240, 320);
      s.scrollFactor.y = 0.1;
      add(s);

      s = new FlxSprite(0,-360);
      s.loadGraphic(ImgBg2, true, true, 240, 640);
      s.scrollFactor.y = 0.16;
      add(s);

      troll = new FlxSprite(0,80);
      troll.loadGraphic(ImgStartZone, true, true, 240, 224);
      troll.addAnimation("trolololo",[1]);
      add(troll);

      s = new FlxSprite(0, -2320);
      s.loadGraphic(ImgBg1, true, true, 240, 2400);
      add(s);
    }
  }
}
