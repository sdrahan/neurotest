package task_5_grid_pattern
{

	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;

	import flash.geom.Rectangle;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;

	/* Further optimization: add initWithPattern(array:Array) method which will re-init this object with new pattern,
	 then pool GridPattern instead of creating new instance every time.
	 */

	public class GridPattern extends Sprite
	{
		private static const SPACING:int = 1;
		private static const CELL_SIZE:int = 30;
		private static const FRAME_THICKNESS:int = 2;

		public function GridPattern( pattern:Array )
		{
			var gridHeight:int = pattern.length;
			var gridWidth:int = pattern[0].length;
			// TODO: Pattern integrity check in case if provided array is not rectangular

			var scaled9BorderImage:Scale9Image = getBorderScaled9Image( gridWidth, gridHeight );
			var bg:Quad = getBackground( gridWidth, gridHeight );

			var renderTexture:RenderTexture = new RenderTexture( gridWidth * CELL_SIZE + 40, gridHeight * CELL_SIZE + 40 );
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

								var cellImage:Image = new Image( getCellTextureByType( pattern[currentY][currentX] ) );
								cellImage.x = (currentX * CELL_SIZE) + (currentX * SPACING) + FRAME_THICKNESS;
								cellImage.y = (currentY * CELL_SIZE) + (currentY * SPACING) + FRAME_THICKNESS;
								renderTexture.draw( cellImage );
							}
						}
						renderTexture.draw( scaled9BorderImage );
					}
			);

			addChild( new Image( renderTexture ) );
		}

		private function getBackground( gridWidth:int, gridHeight:int ):Quad
		{
			var background:Quad = new Quad( (gridWidth * CELL_SIZE) + ((gridWidth - 1) * SPACING), (gridHeight * CELL_SIZE) + ((gridHeight - 1) * SPACING), 0xFFFFFFFF );
			background.x = background.y = FRAME_THICKNESS;
			return background;
		}

		private function getBorderScaled9Image( gridWidth:int, gridHeight:int ):Scale9Image
		{
			var borderTexture:Texture = AssetsManager.instance.getTexture( "grid_bg_frame" );
			var rect:Rectangle = new flash.geom.Rectangle( 10, 10, 20, 20 );	// size of the frame 9 sliced area
			var borderTextures:Scale9Textures = new Scale9Textures( borderTexture, rect );
			var scaled9BorderImage:Scale9Image = new Scale9Image( borderTextures );
			scaled9BorderImage.width = (gridWidth * CELL_SIZE) + ((gridWidth - 1) * SPACING) + (FRAME_THICKNESS * 2);
			scaled9BorderImage.height = (gridHeight * CELL_SIZE) + ((gridHeight - 1) * SPACING) + (FRAME_THICKNESS * 2);
			return scaled9BorderImage;
		}

		private function getCellTextureByType( cellType:int ):Texture
		{
			return AssetsManager.instance.getTexture( "grid_cell_" + cellType );
		}
	}
}
