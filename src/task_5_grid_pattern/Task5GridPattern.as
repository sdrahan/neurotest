package task_5_grid_pattern
{

	import flash.utils.setTimeout;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.RenderTexture;

	public class Task5GridPattern extends Sprite
	{
		private var gridPatterns:Vector.<GridPattern>;
		private var renderTexture:RenderTexture;

		private static const ELEMENTS_COUNT:int = 50;

		public function Task5GridPattern()
		{
			setTimeout( start, 2000 );
		}

		private function start():void
		{
			createGridPatterns();

			useRenderTexture();		// 1 draw call per scene
//			useRegularApproach();	// 1 draw call per element

			// further optimization: pool patterns and re-init them instead of creating new instances
		}

		private function createGridPatterns():void
		{
			// add couple of patterns for testing
			// 0 - empty cell; 1-7 - color of the cell
			var pattern1:Array = [[0, 2, 3, 0, 4], [5, 6, 0, 0, 1], [7, 2, 0, 4, 0], [2, 4, 1, 0, 7]];
			var pattern2:Array = [[1, 2, 1], [4, 0, 4], [0, 7, 0], [2, 1, 2]];

			gridPatterns = new Vector.<GridPattern>();
			for (var i:int = 0; i < ELEMENTS_COUNT; i++)
			{
				gridPatterns.push( new GridPattern( Math.random() > 0.5 ? pattern1 : pattern2 ) );
			}
		}

		// Following approach uses regular children

		private function useRegularApproach():void
		{
			for (var i:int = 0; i < ELEMENTS_COUNT; i++)
			{
				addChild( gridPatterns[i] );
			}

			addEventListener( Event.ENTER_FRAME, onEnterFrameRegular );
		}

		private function onEnterFrameRegular( event:Event ):void
		{
			for (var i:int = 0; i < ELEMENTS_COUNT; i++)
			{
				gridPatterns[i].x = Math.random() * 700;
				gridPatterns[i].y = Math.random() * 500;
			}
		}

		// Following approach uses single render texture

		private function useRenderTexture():void
		{
			renderTexture = new RenderTexture( 800, 600 );
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
					function ()
					{
						for (var i:int = 0; i < ELEMENTS_COUNT; i++)
						{
							gridPatterns[i].x = Math.random() * 700;
							gridPatterns[i].y = Math.random() * 500;
							renderTexture.draw( gridPatterns[i] );
						}
					}
			);
		}

	}
}
