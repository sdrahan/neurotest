package
{

	import flash.display.Stage;
	import flash.geom.Rectangle;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	import task_2_array_shuffling.Task2ArrayShuffling;

	import task_3_date.Task3Date;

	import task_5_grid_pattern.Task5GridPattern;

	[SWF(width="800", height="600", frameRate="60", backgroundColor="#000000")]
	public class Main extends flash.display.Sprite
	{
		private var guiSize:Rectangle = new flash.geom.Rectangle( 0, 0, 900, 600 );
		private var _starling:Starling;
		private var starlingMain:Sprite;
		private var starlingAssetManager:AssetManager;

		public function Main()
		{
			initStarling();
		}

		private function initStarling():void
		{
			_starling = new Starling( Sprite, this.stage as Stage );
			_starling.addEventListener( Event.ROOT_CREATED, onStarlingRootCreated );
			_starling.enableErrorChecking = true;
			_starling.showStats = true;
			_starling.start();
		}

		private function onStarlingRootCreated( event:Event ):void
		{
			starlingMain = event.data as Sprite;

			starlingAssetManager = new AssetManager();
			starlingAssetManager.verbose = true;
			starlingAssetManager.enqueue( EmbeddedAtlas );
			starlingAssetManager.loadQueue( onProgress );

			AssetsManager.instance.setStarlingAssrtManager(starlingAssetManager);
		}

		private function onProgress( ratio:Number ):void
		{
			if (ratio == 1)
			{
				start();
			}
		}

		private function start():void
		{
			showMainMenu();
		}

		private function showMainMenu():void
		{
			trace( "Init complete" );
			var task5GridPattern:Task5GridPattern = new Task5GridPattern();
			starlingMain.addChild(task5GridPattern);
		}
	}
}
