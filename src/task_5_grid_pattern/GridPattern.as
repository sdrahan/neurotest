package task_5_grid_pattern
{

	import feathers.display.Scale9Image;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.RenderTexture;

	public class GridPattern extends Sprite
	{
		private var image:Image;
		private var renderTexture:RenderTexture;

		private static const SPACING:int = 1;
		private static const CELL_SIZE:int = 30;
		private static const FRAME_THICKNESS:int = 2;

		public function GridPattern()
		{

		}

		public function createFromPattern( pattern:Array, images:Vector.<Image>, scaledBackground:Scale9Image ):void
		{
			var gridHeight:int = pattern.length;
			var gridWidth:int = pattern[0].length;

			scaledBackground.width = (gridWidth * CELL_SIZE) + ((gridWidth - 1) * SPACING) + (FRAME_THICKNESS * 2);
			scaledBackground.height = (gridHeight * CELL_SIZE) + ((gridHeight - 1) * SPACING) + (FRAME_THICKNESS * 2);
			var bg:Quad = getBackgroundQuad( gridWidth, gridHeight );

			renderTexture = new RenderTexture( gridWidth * CELL_SIZE + 40, gridHeight * CELL_SIZE + 40 );
			renderTexture.drawBundled(
					function ():void
					{
						renderTexture.draw( bg );

						for (var currentY:int = 0; currentY < gridHeight; currentY++)
						{
							for (var currentX:int = 0; currentX < gridWidth; currentX++)
							{
								if (pattern[currentY][currentX] == 0)
								{
									continue;
								}

								var cellImage:Image = images[pattern[currentY][currentX] - 1];
								cellImage.x = (currentX * CELL_SIZE) + (currentX * SPACING) + FRAME_THICKNESS;
								cellImage.y = (currentY * CELL_SIZE) + (currentY * SPACING) + FRAME_THICKNESS;
								renderTexture.draw( cellImage );
							}
						}
						renderTexture.draw( scaledBackground );
					}
			);

			if (!image)
			{
				image = new Image( renderTexture );
				addChild( image );
			}
			else
			{
				image.texture = renderTexture;
			}
		}

		public function cleanUp():void
		{
			if (renderTexture != null)
			{
				renderTexture.dispose();
			}
		}

		private function getBackgroundQuad( gridWidth:int, gridHeight:int ):Quad
		{
			var background:Quad = new Quad( (gridWidth * CELL_SIZE) + ((gridWidth - 1) * SPACING), (gridHeight * CELL_SIZE) + ((gridHeight - 1) * SPACING), 0xFFFFFFFF );
			background.x = background.y = FRAME_THICKNESS;
			return background;
		}
	}
}
