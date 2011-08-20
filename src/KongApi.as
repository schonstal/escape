package
{
    import flash.display.DisplayObject;
    import flash.display.LoaderInfo;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.system.Security;
     
    public class KongApi extends Sprite
    {
        public function KongApi() { }

        public function init():void
        {
            // Pull the API path from the FlashVars
            var paramObj:Object = LoaderInfo(root.loaderInfo).parameters;
             
            // The API path. The "shadow" API will load if testing locally. 
            var apiPath:String = paramObj.kongregate_api_path || 
              "http://www.kongregate.com/flash/API_AS3_Local.swf";
             
            // Allow the API access to this SWF
            Security.allowDomain(apiPath);
             
            // Load the API
            var request:URLRequest = new URLRequest(apiPath);
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
            loader.load(request);
            this.addChild(loader);
        }
         
        // Kongregate API reference
        public var kongregate:*;
         
        // This function is called when loading is complete
        private function loadComplete(event:Event):void
        {
            // Save Kongregate API reference
            kongregate = event.target.content;
         
            // Connect to the back-end
            kongregate.services.connect();
         
            // You can now access the API via:
            // kongregate.services
            // kongregate.user
            // kongregate.scores
            // kongregate.stats
            // etc...
        }
    }
}
