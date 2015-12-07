package task_1_rotator_component.components.linearRotator
{

	import flash.geom.Point;

	public class VerticalLinearRotatorLayout implements ILinearRotatorLayout
	{
		private var spacing:int = 0;
		private var topOffset:int = 0;

		public function VerticalLinearRotatorLayout( spacing:int = 16, topOffset = 0 )
		{
			this.spacing = spacing;
			this.topOffset = topOffset;
		}

		public function getNewCoordsForItem( item:RotatorItemRenderer ):Point
		{
			return new Point( item.x, item.y - item.getSize().height - spacing );
		}

		public function updateItemPositions( items:Vector.<RotatorItemRenderer> ):void
		{
			var currentY:int = topOffset;
			for (var i:int = 0; i < items.length; i++)
			{
				items[i].x = 0;
				items[i].y = currentY;

				currentY += items[i].getSize().height + spacing;
			}
		}
	}
}
