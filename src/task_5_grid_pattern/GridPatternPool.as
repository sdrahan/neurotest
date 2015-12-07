/**
 * Created by sergd on 12/7/2015.
 */
package task_5_grid_pattern
{

	import feathers.display.Scale9Image;

	import starling.display.Image;

	public class GridPatternPool
	{
		private var poolActive:Vector.<GridPattern>;
		private var poolInactive:Vector.<GridPattern>;

		private var cellImagesVector:Vector.<Image>;
		private var borderScale9Image:Scale9Image;

		public function GridPatternPool( cellImagesVector:Vector.<Image>, borderScale9Image:Scale9Image )
		{
			poolActive = new <GridPattern>[];
			poolInactive = new <GridPattern>[];

			this.cellImagesVector = cellImagesVector;
			this.borderScale9Image = borderScale9Image;
		}

		public function getGridPattern( pattern:Array ):GridPattern
		{
			var gridPattern:GridPattern;
			if (poolInactive.length > 0)
			{
				gridPattern = poolInactive.pop();
			}
			else
			{
				gridPattern = new GridPattern();
			}
			poolActive.push( gridPattern );
			gridPattern.createFromPattern( pattern, cellImagesVector, borderScale9Image );
			return gridPattern;
		}

		public function releaseGridPattern( gridPattern:GridPattern ):void
		{
			gridPattern.cleanUp();
			var index:int = poolActive.indexOf( gridPattern );
			if (index >= 0)
			{
				poolActive.splice( index, 1 );
			}
			poolInactive.push( gridPattern );
		}
	}
}
