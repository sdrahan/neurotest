package
{

	import flash.display.Stage;
	import flash.events.Event;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;

	import task_1_rotator_component.Task1RotatorComponent;

	import task_4_path.Task4PathBuilder;

	import task_5_grid_pattern.Task5GridPattern;

	[SWF(width="640", height="480", frameRate="60", backgroundColor="#34455B")]
	public class Main extends flash.display.Sprite
	{
		private var _starling:Starling;
		private var starlingMain:Sprite;
		private var mainMenu:MainMenu;

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
			mainMenu.addEventListener( MainMenu.TASK_1, onTaskSelected );
			mainMenu.addEventListener( MainMenu.TASK_4, onTaskSelected );
			mainMenu.addEventListener( MainMenu.TASK_5, onTaskSelected );
			mainMenu.addEventListener( MainMenu.TASK_5_RT, onTaskSelected );
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

		private function onTaskSelected( event:flash.events.Event ):void
		{
			var task:DisplayObject;
			switch (event.type)
			{
				case MainMenu.TASK_1:
					task = new Task1RotatorComponent();
					break;

				case MainMenu.TASK_4:
					task = new Task4PathBuilder();
					break;

				case MainMenu.TASK_5:
					task = new Task5GridPattern( false );
					break;

				case MainMenu.TASK_5_RT:
					task = new Task5GridPattern( true );
					break;
			}

			starlingMain.addChild( task );
			task.addEventListener( "Exit", onTaskExit );
			hideMainMenu();
		}

		private function onTaskExit( event:starling.events.Event ):void
		{
			var task:DisplayObject = event.currentTarget as DisplayObject;
			task.removeEventListener( "Exit", onTaskExit );
			starlingMain.removeChild( task );
			showMainMenu();
		}
	}
}
