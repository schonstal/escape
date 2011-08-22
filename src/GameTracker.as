package
{
    import org.flixel.*;

    public class GameTracker
    {
        public var _score:Number;
        public var _highScore:Number;
        public var _save:FlxSave;
        public var _playedMusic:Boolean;

        public var _api:KongApi;

        private static var _instance:GameTracker = null;
        public function GameTracker() {
        }

        private static function get instance():GameTracker {
            if(_instance == null) {
                _instance = new GameTracker();
                _instance._score = 0;
                instance._save = new FlxSave();
                instance._save.bind("escape-game");
                _instance._highScore = instance._save.data.highScore;
            }

            return _instance;
        }

        public static function get score():Number {
            return instance._score;
        }

        public static function get highScore():Number {
            return instance._highScore;
        }

        public static function set score(value:Number):void {
            instance._score = value;
            if(instance._score > instance._highScore) {
                instance._highScore = instance._score;
                instance._save.data.highScore = instance._score;
            }
        }

        public static function get api():KongApi {
            return instance._api;
        }

        public static function set api(value:KongApi):void {
            instance._api = value;
        }

        public static function get playedMusic():Boolean {
            return instance._playedMusic;
        }

        public static function set playedMusic(value:Boolean):void {
            instance._playedMusic = value;
        }
    }
}
