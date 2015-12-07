package task_5_grid_pattern
{

	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;

	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.setTimeout;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;

	public class Task5GridPattern extends Sprite
	{
		private var gridPatterns:Vector.<GridPattern>;
		private var renderTexture:RenderTexture;
		private var pool:GridPatternPool;
		private var elementsCount:int = 0;
		private var exitButton:Button;

		private static const INITIAL_ELEMENTS_COUNT:int = 50;

		public function Task5GridPattern( useRenderTexture:Boolean )
		{
			setTimeout( start, 500, useRenderTexture );	// small timeout just so everything is not happening in the constructor
		}

		private function start( useRenderTexture:Boolean ):void
		{
			gridPatterns = new Vector.<GridPattern>();
			initPool();

			if (useRenderTexture)
			{
				useRenderTextureApproach();		// 1 draw call per scene
			}
			else
			{
				useRegularApproach();			// 1 draw call per element
			}

			addGridPatterns( INITIAL_ELEMENTS_COUNT );

			addKeyboardEventListeners();
			addExitButton();
		}

		private function addGridPatterns( count:int ):void
		{
			// 0 - empty cell; 1-7 - color of the cell
			var pattern1:Array = [[0, 2, 3, 0, 4], [5, 6, 0, 0, 1], [7, 2, 0, 4, 0], [2, 4, 1, 0, 7]];
			var pattern2:Array = [[1, 2, 1], [4, 0, 4], [0, 7, 0], [2, 1, 2]];

			for (var i:int = 0; i < count; i++)
			{
				var gridPattern:GridPattern = pool.getGridPattern( Math.random() > 0.5 ? pattern1 : pattern2 );
				gridPattern.x = Math.random() * 400 + 50;
				gridPattern.y = Math.random() * 370;
				gridPatterns.push( gridPattern );

				if (renderTexture == null)	// if null - we're using "regular" approach
				{
					addChild( gridPattern );
				}
			}

			elementsCount += count;
		}

		private function removeGridPatterns( count:int ):void
		{
			if (gridPatterns.length == 0)
			{
				return;
			}

			for (var i:int = 0; i < count; i++)
			{
				var gridPattern:GridPattern = gridPatterns.pop();
				pool.releaseGridPattern( gridPattern );

				if (gridPattern.parent != null)	// it will be null in "renderTexture" approach
				{
					gridPattern.parent.removeChild( gridPattern );
				}

				elementsCount--;
				if (elementsCount == 0)
				{
					return;
				}
			}
		}

		// =========================================
		// Following approach uses regular children:

		private function useRegularApproach():void
		{
			addEventListener( Event.ENTER_FRAME, onEnterFrameRegular );
		}

		private function onEnterFrameRegular( event:Event ):void
		{
			for (var i:int = 0; i < elementsCount; i++)
			{
				gridPatterns[i].x += Math.random() * 2 - 1;
				gridPatterns[i].y += Math.random() * 2 - 1;
			}
		}

		// =========================================
		// Following approach uses single render texture:

		private function useRenderTextureApproach():void
		{
			renderTexture = new RenderTexture( 640, 480 );
			updateRenderTexture();
			var image:Image = new Image( renderTexture );
			addChild( image );
			addEventListener( Event.ENTER_FRAME, onEnterFrameRenderTexture );
		}

		private function onEnterFrameRenderTexture( event:Event ):void
		{
			renderTexture.clear();
			updateRenderTexture();
		}

		private function updateRenderTexture():void
		{
			renderTexture.drawBundled(
					function ():void
					{
						for (var i:int = 0; i < elementsCount; i++)
						{
							gridPatterns[i].x += Math.random() * 2 - 1;
							gridPatterns[i].y += Math.random() * 2 - 1;
							renderTexture.draw( gridPatterns[i] );
						}
					}
			);
		}

		// =========================================
		// pool-related things:

		private function initPool():void
		{
			// performance measurements show that using pool with precreated images takes up to 20% less time when instantiating new GridPatterns
			pool = new GridPatternPool( getCellImagesVector(), getScaled9BorderImage() );
		}

		private function getCellImagesVector():Vector.<Image>
		{
			var images:Vector.<Image> = new <Image>[
				new Image( AssetsManager.instance.getTexture( "grid_cell_1" ) ),
				new Image( AssetsManager.instance.getTexture( "grid_cell_2" ) ),
				new Image( AssetsManager.instance.getTexture( "grid_cell_3" ) ),
				new Image( AssetsManager.instance.getTexture( "grid_cell_4" ) ),
				new Image( AssetsManager.instance.getTexture( "grid_cell_5" ) ),
				new Image( AssetsManager.instance.getTexture( "grid_cell_6" ) ),
				new Image( AssetsManager.instance.getTexture( "grid_cell_7" ) )];
			return images;
		}

		private function getScaled9BorderImage():Scale9Image
		{
			var borderTexture:Texture = AssetsManager.instance.getTexture( "grid_bg_frame" );
			var rect:Rectangle = new flash.geom.Rectangle( 10, 10, 20, 20 );	// size of the frame 9 sliced area
			var borderTextures:Scale9Textures = new Scale9Textures( borderTexture, rect );
			var scaled9BorderImage:Scale9Image = new Scale9Image( borderTextures );
			return scaled9BorderImage;
		}

		private function addKeyboardEventListeners():void
		{
			addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		}

		private function onKeyDown( event:KeyboardEvent ):void
		{
			if (event.keyCode == Keyboard.UP)
			{
				addGridPatterns( INITIAL_ELEMENTS_COUNT );
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				removeGridPatterns( INITIAL_ELEMENTS_COUNT );
			}
		}

		private function addExitButton():void
		{
			exitButton = new Button( AssetsManager.instance.getTexture( "button_exit_out" ), "", AssetsManager.instance.getTexture( "button_exit_down" ) );
			exitButton.addEventListener( Event.TRIGGERED, onExitButtonTriggered );
			exitButton.x = 0;
			exitButton.y = 430;
			addChild( exitButton );
		}

		private function onExitButtonTriggered( event:Event ):void
		{
			cleanUp();
			dispatchEvent( new Event( "Exit" ) );
		}

		private function cleanUp():void
		{
			exitButton.removeEventListener( Event.TRIGGERED, onExitButtonTriggered );
			removeEventListener( Event.ENTER_FRAME, onEnterFrameRegular );
			removeEventListener( Event.ENTER_FRAME, onEnterFrameRenderTexture );
			removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		}

	}
}
