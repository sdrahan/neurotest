package task_1_rotator_component.components.linearRotator
{

	import flash.geom.Point;

	public interface ILinearRotatorLayout
	{
		function getNewCoordsForItem( item:RotatorItemRenderer ):Point;

		function updateItemPositions( items:Vector.<RotatorItemRenderer> ):void;
	}
}
