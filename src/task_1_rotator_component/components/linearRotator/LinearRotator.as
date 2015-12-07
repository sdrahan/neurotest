package task_1_rotator_component.components.linearRotator
{

	import com.greensock.TweenMax;

	import flash.geom.Point;

	import starling.display.Sprite;

	public class LinearRotator extends Sprite
	{
		private var items:Vector.<RotatorItemRenderer>;
		private var highlightedItemIndex:int;
		private var isInMotion:Boolean = false;
		private var layout:ILinearRotatorLayout;

		private static const SHIFT_ANIMATION_DURATION:Number = 0.5;

		public function LinearRotator( itemClass:Class, dataVOs:Vector.<RotatorItemDataVO>, highlightedItemIndex:int, layout:ILinearRotatorLayout )
		{
			items = new <RotatorItemRenderer>[];
			this.layout = layout;

			checkAndSetHighlightedIndex( highlightedItemIndex, dataVOs.length );
			createInitialItems( itemClass, dataVOs );
			layout.updateItemPositions( items );

			items[highlightedItemIndex].highlight();
		}

		private function checkAndSetHighlightedIndex( highlightedIndex:int, itemsCount:int ):void
		{
			if (highlightedIndex < itemsCount)
			{
				highlightedItemIndex = highlightedIndex;
			}
			else
			{
				highlightedItemIndex = itemsCount - 1;
			}
		}

		private function createInitialItems( itemClass:Class, dataVOs:Vector.<RotatorItemDataVO> ):void
		{
			for (var i:int = 0; i < dataVOs.length + 1; i++)
			{
				var item:RotatorItemRenderer = (new itemClass()) as RotatorItemRenderer;
				items.push( item );

				if (i < dataVOs.length)	// we won't add any data to the last created item - it will be created as a "spare" one
				{
					item.setDataVO( dataVOs[i] );
					addChild( item );
					item.init();
				}
			}
		}

		public function pushItemDataVO( dataVO:RotatorItemDataVO, customStateForUnhighlightedElement:String = "" ):void
		{
			if (isInMotion)
			{
				stopMotionImmediately();
			}

			setupLastItemWithDataVO( dataVO );
			layout.updateItemPositions( items );
			items[highlightedItemIndex].unhighlight( customStateForUnhighlightedElement );
			items[highlightedItemIndex + 1].highlight();
			moveFirstItemToTheEnd();
			displayShiftAnimation();
		}

		private function setupLastItemWithDataVO( dataVO:RotatorItemDataVO ):void
		{
			var lastItem:RotatorItemRenderer = items[items.length - 1];
			lastItem.setDataVO( dataVO );
			lastItem.init();
			lastItem.fadeIn();
			addChild( lastItem );
		}

		private function stopMotionImmediately():void
		{
			for (var i:int = 0; i < items.length; i++)
			{
				TweenMax.killTweensOf( items[i] );
			}
			layout.updateItemPositions( items );
			isInMotion = false;
		}

		private function moveFirstItemToTheEnd():void
		{
			var firstItem:RotatorItemRenderer = items.shift();
			firstItem.fadeOut();
			items.push( firstItem );
		}

		private function displayShiftAnimation():void
		{
			for (var i:int = 0; i < items.length; i++)
			{
				var newCoordsForItem:Point = layout.getNewCoordsForItem( items[i] );
				TweenMax.to(
						items[i], SHIFT_ANIMATION_DURATION, {
							x: newCoordsForItem.x,
							y: newCoordsForItem.y,
							onComplete: function ():void
							{
								isInMotion = false
							}
						}
				);
			}
			isInMotion = true;
		}

		public function getCurrentHighlightedDataVO():RotatorItemDataVO
		{
			return items[highlightedItemIndex].getDataVO();
		}
	}
}
