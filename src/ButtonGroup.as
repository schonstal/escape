package {
	import org.flixel.*;
	import com.teamclew.TCGame;

	public class ButtonGroup extends FlxGroup {
		private var fButton : FullScreenButton;
		private var wButton : WindowButton;
		
		public function ButtonGroup() : void {
			var button : FlxButton;
			 button = new TwitterButton();
			 add(button);
			
			 button = new FacebookButton();
			 add(button);

			fButton = new FullScreenButton();
			add(fButton);
			
			wButton = new WindowButton();
			add(wButton);

			// button = new IncredibleApeButton();
			// add(button);
		}

		override public function update() : void {
			if (TCGame.game.isFullscreen && wButton.x != wButton.startX) {
				fButton.x = fButton.startX + 1000;
				wButton.x = wButton.startX;
			} else if (!TCGame.game.isFullscreen && fButton.x != fButton.startX ){
				fButton.x = fButton.startX;
				wButton.x = wButton.startX + 1000;
			}
			super.update();
		}
	}
}
