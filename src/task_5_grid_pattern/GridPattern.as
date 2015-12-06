/**
 * Created by sergd on 12/6/2015.
 */
package task_5_grid_pattern
{

	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;

	import flash.geom.Rectangle;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.QuadBatch;

	import starling.display.Sprite;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;

	public class GridPattern extends Sprite
	{
		private static const SPACING:int = 1;
		private static const CELL_SIZE:int = 30;
		private static const FRAME_THICKNESS:int = 2;

		public function GridPattern( pattern:Array )
		{
			var gridHeight:int = pattern.length;
			var gridWidth:int = pattern[0].length;

			// TODO: Pattern integrity check

			var borderTexture:Texture = AssetsManager.instance.getTexture( "grid_bg_frame" );
			var rect:Rectangle = new flash.geom.Rectangle( 10, 10, 20, 20 );	// size of the frame 9 sliced area
			var borderTextures:Scale9Textures = new Scale9Textures( borderTexture, rect );
			var scaled9BorderImage:Scale9Image = new Scale9Image( borderTextures );
			scaled9BorderImage.width = (gridWidth * CELL_SIZE) + ((gridWidth - 1) * SPACING) + (FRAME_THICKNESS * 2);
			scaled9BorderImage.height = (gridHeight * CELL_SIZE) + ((gridHeight - 1) * SPACING) + (FRAME_THICKNESS * 2);

			var bg:Quad = new Quad((gridWidth * CELL_SIZE) + ((gridWidth - 1) * SPACING), (gridHeight * CELL_SIZE) + ((gridHeight - 1) * SPACING), 0xFFFFFFFF);
			bg.x = bg.y = FRAME_THICKNESS;

			var t:RenderTexture = new RenderTexture(gridWidth * CELL_SIZE + 40, gridHeight * CELL_SIZE + 40);
			t.drawBundled(
					function():void
					{
						t.draw(bg);

						var cellTexture:Texture = AssetsManager.instance.getTexture( "grid_cell" );
						for (var currentY:int = 0; currentY < gridHeight; currentY++)
						{
							for (var currentX:int = 0; currentX < gridWidth; currentX++)
							{
								if (pattern[currentY][currentX] == 0)
								{
									continue;
								}

								var cellImage:Image = new Image(getTextureByCellType(pattern[currentY][currentX]));
								cellImage.x = (currentX * CELL_SIZE) + (currentX * SPACING) + FRAME_THICKNESS;
								cellImage.y = (currentY * CELL_SIZE) + (currentY * SPACING) + FRAME_THICKNESS;
								t.draw( cellImage );
							}
						}
						t.draw(scaled9BorderImage);
					}
			);

			addChild(new Image(t));
		}

		private function getTextureByCellType(cellType:int):Texture
		{
			AssetsManager.instance.getTexture("grid_cell_" + cellType);
		}
	}
}
