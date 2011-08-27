package
{
  import org.flixel.*;

  public class StartButton extends FlxButton
  {
    [Embed(source = "../data/startGame.png")] private var ImgStartGame:Class;

    public function StartButton(X:Number, Y:Number):void {
      super(X,Y);

      scrollFactor.x = scrollFactor.y = 0;

      loadGraphic(ImgStartGame, true, true, 150, 26);
      width = 150;
      height = 26;

      addAnimation("off", [0]);
      addAnimation("on", [1]);

      onUp =  function():void { 
        FlxG.music.fadeOut(1);
        FlxG.fade(0xff000000,1,function():void {
          FlxG.switchState(new PlayState());
        });
      };

      onOver = function():void { play("on"); };

      onOut = function():void { play("off"); };
    }
  }
}
