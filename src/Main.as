package
{

	import flash.display.Stage;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	import task_1_rotator_component.Task1RotatorComponent;

	[SWF(width="800", height="600", frameRate="60", backgroundColor="#000000")]
	public class Main extends flash.display.Sprite
	{
		private var starling:Starling;
		private var starlingMain:Sprite;
		private var starlingAssetManager:AssetManager;

		public function Main()
		{
			initStarling();
		}

		private function initStarling():void
		{
			starling = new Starling( Sprite, this.stage as Stage );
			starling.addEventListener( Event.ROOT_CREATED, onStarlingRootCreated );
			starling.enableErrorChecking = true;
			starling.showStats = true;
			starling.start();
		}

		private function onStarlingRootCreated( event:Event ):void
		{
			starlingMain = event.data as Sprite;

			starlingAssetManager = new AssetManager();
			starlingAssetManager.verbose = true;
			starlingAssetManager.enqueue( EmbeddedAtlas );
			starlingAssetManager.loadQueue( onProgress );

			AssetsManager.instance.setStarlingAssrtManager( starlingAssetManager );
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
			var task:Task1RotatorComponent = new Task1RotatorComponent();
			starlingMain.addChild( task );
		}
	}
}
