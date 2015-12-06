package task_5_grid_pattern
{

	import flash.utils.setTimeout;

	import starling.display.Image;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.RenderTexture;

	public class Task5GridPattern extends Sprite
	{
		public function Task5GridPattern()
		{
			setTimeout(start, 2000);
		}

		private var gridPatterns:Vector.<GridPattern>;

		private var t:RenderTexture;
		private var image:Image;

		private function start():void
		{
			var pattern:Array = [[1, 1, 1], [1, 0, 1], [0, 1, 0], [1, 1, 1]];
			var pattern1:Array = [[0, 1, 1, 0, 1], [1, 1, 0, 0, 1], [1, 1, 0, 1, 0], [1, 1, 1, 0, 1]];
			gridPatterns = new Vector.<GridPattern>();

			for (var i:int = 0; i < 100; i++)
			{
				gridPatterns.push( new GridPattern( Math.random() > 0.5 ? pattern : pattern1 ) );
			}

//			for (var i:int = 0; i < 100; i++)
//			{
//				gridPatterns[i].x = Math.random() * 700;
//				gridPatterns[i].y = Math.random() * 500;
//				addChild(gridPatterns[i]);
//			}

			t = new RenderTexture( 800, 600 );
			t.drawBundled(
					function()
					{
						for (var i:int = 0; i < 100; i++)
						{
							gridPatterns[i].x = Math.random() * 700;
							gridPatterns[i].y = Math.random() * 500;
							t.draw( gridPatterns[i] );
						}
					}
			);
			image = new Image(t);
			addChild(image);

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame( event:Event ):void
		{
			t.clear();
			t.drawBundled(
					function()
					{
						for (var i:int = 0; i < 100; i++)
						{
							gridPatterns[i].x = Math.random() * 700;
							gridPatterns[i].y = Math.random() * 500;
							t.draw( gridPatterns[i] );
						}
					}
			);

//			for (var i:int = 0; i < 100; i++)
//			{
//				gridPatterns[i].x = Math.random() * 700;
//				gridPatterns[i].y = Math.random() * 500;
//			}
		}
	}
}
