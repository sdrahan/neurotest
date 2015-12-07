package task_1_rotator_component.components.linearRotator
{

	import flash.geom.Point;

	public class HorizontalLinearRotatorLayout implements ILinearRotatorLayout
	{
		private var spacing:int = 0;
		private var leftOffset:int = 0;

		public function HorizontalLinearRotatorLayout( spacing:int = 16, leftOffset = 0 )
		{
			this.spacing = spacing;
			this.leftOffset = leftOffset;
		}

		public function getNewCoordsForItem( item:RotatorItemRenderer ):Point
		{
			return new Point( item.x - item.getSize().width - spacing, item.y );
		}

		public function updateItemPositions( items:Vector.<RotatorItemRenderer> ):void
		{
			var currentX:int = leftOffset;
			for (var i:int = 0; i < items.length; i++)
			{
				items[i].x = currentX;
				items[i].y = 0;

				currentX += items[i].getSize().width + spacing;
			}
		}
	}
}
