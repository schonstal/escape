package {
	import org.flixel.*;

	import com.teamclew.TCGame;

	public class FullScreenButton extends FlxButton {
		[Embed(source = "data/fullscreen.png")] private var ImgFullscreen : Class;

		public var startX:int;

		public function FullScreenButton() : void {
			super(FlxG.width - 54 - 2  - 146, FlxG.height - 22 - 2);

			loadGraphic(ImgFullscreen, true, true, 18, 18);
			startX = x;
			scrollFactor.x = scrollFactor.y = 0;

			if (TCGame.game.isFullscreen) this.x = startX + 1000; 

			addAnimation("off", [0]);
			addAnimation("on", [1]);

			onUp = function() : void {
				TCGame.game.toggleFullScreen();
				this.x = startX + 1000;
			};

			onOver = function() : void {
				play("on");
			};

			onOut = function() : void {
				play("off");
			};
		}
	}
}



      