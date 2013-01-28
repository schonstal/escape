package com.teamclew {
	import org.flixel.*;

	import flash.ui.Mouse;
	import flash.events.*;
//	import flash.display.StageDisplayState;
//	import flash.display.StageScaleMode;
	import flash.display.*;
//	import flash.desktop.
	import flash.events.KeyboardEvent;
	import flash.system.fscommand;
	
	import flash.display.DisplayObject;
	
	
	public class TCGame extends FlxGame {
		
		static public var game:TCGame;
		
		public var isFullscreen:Boolean;
		
		private static const ROTATION_NORMAL:Number = 0;
		private static const ROTATION_LEFT:Number = 1;
		private static const ROTATION_UPSIDEDOWN:Number = 2;
		private static const ROTATION_RIGHT:Number = 3;
		
		private static const ROTATION_VALUE:Number = 90;
		private var currentRotation:int = 0;
		
		
		public function TCGame(GameSizeX : uint, GameSizeY : uint, InitialState : Class, Zoom : Number = 1, GameFramerate : uint = 60, FlashFramerate : uint = 30, UseSystemCursor : Boolean = false) {
			super(GameSizeX, GameSizeY, InitialState, Zoom, GameFramerate, FlashFramerate, UseSystemCursor);
			
			game = this;
			
			// wait until we're added to the stage
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		// setup resize handler
		public function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, function():void {
				Mouse.show();
			});
			stage.addEventListener(KeyboardEvent.KEY_DOWN, function():void {
				Mouse.hide();
				// seems to be ignored if the mouse isn't over 
				// the swf the first time you go full screen
			});
			
//			stage.addEventListener(MouseEvent.MOUSE_UP, function():void {
//				Mouse.show();
//				Mouse.hide();
//				// seems to be ignored if the mouse isn't over 
//				// the swf the first time you go full screen
//			});
			
//			stage.scaleMode = StageScaleMode.NO_SCALE; // reseting the scale to get actual width
//			trace(stage.stageWidth); // this is where you getting the width you need
//			stage.scaleMode = StageScaleMode.SHOW_ALL; // setting back the scale.
			
			stage.addEventListener(Event.RESIZE, onResize);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onResize);
			stage.addEventListener(Event.ACTIVATE, onResize);
			stage.displayState = StageDisplayState.FULL_SCREEN;
			isFullscreen = true;
			
			onResize(event);
			
			fscommand( "trapallkeys", "true" );
			fscommand( "showmenu", "false"); // Mac only
			stage.showDefaultContextMenu = false; // PC (and mac?)
			stage.addEventListener(MouseEvent.RIGHT_CLICK, function(e:Event):void{});
		}
		
//		public function firstFullScreen():void
//		{
//			if (isFullscreen && stage.displayState == StageDisplayState.NORMAL) {
//				 stage.displayState = StageDisplayState.FULL_SCREEN;
//				 onResize();
//			}
//		}
		
		public function toggleFullScreen():void
		{
			if (stage.displayState == StageDisplayState.FULL_SCREEN || stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) {
				stage.displayState = StageDisplayState.NORMAL;
				isFullscreen = false;
			} else if (stage.displayState == StageDisplayState.NORMAL) {
				stage.displayState = StageDisplayState.FULL_SCREEN;
				isFullscreen = true;
			}
		}		
		
		public function rotateGame(turnRight:Boolean = true):void
		{
			if (turnRight) {
				currentRotation++;
				if (currentRotation > ROTATION_RIGHT) currentRotation = ROTATION_NORMAL;
			} else {
				currentRotation--;
				if (currentRotation < ROTATION_NORMAL) currentRotation = ROTATION_RIGHT;
			}
			onResize();
		}
		
		// scales to fit window/screen
		public function onResize(event:Event = null):void
		{						
			Mouse.hide();
			
			// determine optimum zoom
			var zoomX:Number = stage.stageWidth / FlxG.width;
			var zoomY:Number = stage.stageHeight / FlxG.height;
			if (currentRotation == ROTATION_LEFT || currentRotation == ROTATION_RIGHT) {
				zoomX = stage.stageHeight / FlxG.width;
				zoomY = stage.stageWidth / FlxG.height;
			}

			var zoom:Number = (zoomX <= zoomY) ? zoomX : zoomY;
//			zoom = Math.floor(zoom); // floor to force uniform pixels 
			if (zoom < 1) zoom = 1;
			scaleX = scaleY = zoom; // this doesn't appear to have any effect on Flash Player's memory usage - WIN!
			
			 if (currentRotation == ROTATION_NORMAL ) {
				x = Math.floor((stage.stageWidth - FlxG.width * zoom) / 2);
				y = Math.floor((stage.stageHeight - FlxG.height * zoom) / 2);
			} else if (currentRotation == ROTATION_LEFT) {
				x = Math.floor((stage.stageWidth + FlxG.height * zoom) / 2);
				y = Math.floor((stage.stageHeight - FlxG.width * zoom) / 2);
			} else if (currentRotation == ROTATION_RIGHT) {
				x = Math.floor((stage.stageWidth - FlxG.height * zoom) / 2);
				y = Math.floor((stage.stageHeight + FlxG.width * zoom) / 2);
			} else if (currentRotation == ROTATION_UPSIDEDOWN) {
				x = Math.floor((stage.stageWidth + FlxG.width * zoom) / 2);
				y = Math.floor((stage.stageHeight + FlxG.height * zoom) / 2);
			}
			
			this.rotation = ROTATION_VALUE * currentRotation;
		}
	}
}
