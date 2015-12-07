package
{

	import flash.display.Stage;
	import flash.events.Event;

	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	import task_1_rotator_component.Task1RotatorComponent;

	import task_5_grid_pattern.Task5GridPattern;

	[SWF(width="640", height="480", frameRate="60", backgroundColor="#34455B")]
	public class Main extends flash.display.Sprite
	{
		private var _starling:Starling;
		private var starlingMain:Sprite;
		private var mainMenu:MainMenu;

		private var task1:Task1RotatorComponent;
		private var task5:Task5GridPattern;

		public function Main()
		{
			initStarling();
		}

		private function initStarling():void
		{
			_starling = new Starling( Sprite, this.stage as Stage );
			_starling.addEventListener( starling.events.Event.ROOT_CREATED, onStarlingRootCreated );
			_starling.enableErrorChecking = true;
			_starling.showStats = true;
			_starling.start();
		}

		private function onStarlingRootCreated( event:starling.events.Event ):void
		{
			starlingMain = event.data as Sprite;

			var starlingAssetManager:AssetManager = new AssetManager();
			starlingAssetManager.verbose = true;
			starlingAssetManager.enqueue( EmbeddedAtlas );
			starlingAssetManager.enqueue( EmbeddedFonts );
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
			mainMenu = new MainMenu();
			mainMenu.addEventListener( MainMenu.TASK_1, addTask1 );
			mainMenu.addEventListener( MainMenu.TASK_5, addTask5 );
			mainMenu.addEventListener( MainMenu.TASK_5_RT, addTask5WithRenderTexture );
			showMainMenu();
		}

		private function addTask1( event:flash.events.Event ):void
		{
			task1 = new Task1RotatorComponent();
			starlingMain.addChild( task1 );
			task1.addEventListener( "Exit", onTask1Exit );
			hideMainMenu();
		}

		private function onTask1Exit( event:starling.events.Event ):void
		{
			starlingMain.removeChild( task1 );
			task1.removeEventListener( "Exit", onTask1Exit );
			task1 = null;
			showMainMenu();
		}

		private function addTask5( event:flash.events.Event ):void
		{
			task5 = new Task5GridPattern(false);	// start without using single RenderTexture
			starlingMain.addChild( task5 );
			task5.addEventListener( "Exit", onTask5Exit );
			hideMainMenu();
		}

		private function addTask5WithRenderTexture( event:flash.events.Event ):void
		{
			task5 = new Task5GridPattern(true);	// start with using single RenderTexture
			starlingMain.addChild( task5 );
			task5.addEventListener( "Exit", onTask5Exit );
			hideMainMenu();
		}

		private function onTask5Exit( event:starling.events.Event ):void
		{
			starlingMain.removeChild( task5 );
			task5.removeEventListener( "Exit", onTask5Exit );
			task5 = null;
			showMainMenu();
		}

		private function showMainMenu():void
		{
			addChild( mainMenu );
		}

		private function hideMainMenu():void
		{
			removeChild( mainMenu );
		}
	}
}
