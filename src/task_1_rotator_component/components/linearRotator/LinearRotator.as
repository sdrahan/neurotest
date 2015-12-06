package task_1_rotator_component.components.linearRotator
{

	import com.greensock.TweenMax;

	import starling.display.Sprite;

	public class LinearRotator extends Sprite
	{
		private var items:Vector.<RotatorItemRenderer>;
		private var highlightedItemIndex:int;
		private var isInMotion:Boolean = false;

		private static const SPACING:int = 20;
		private static const OFFSET:int = 10;
		private static const SIZE:int = 40;

		public function LinearRotator( itemClass:Class, dataVOs:Vector.<RotatorItemDataVO>, highlightedIndex:int )
		{
			items = new <RotatorItemRenderer>[];

			if (highlightedIndex < dataVOs.length)
			{
				highlightedItemIndex = highlightedIndex;
			}
			else
			{
				highlightedItemIndex = dataVOs.length - 1;
			}

			for (var i:int = 0; i < dataVOs.length + 1; i++)
			{
				var item:RotatorItemRenderer = (new itemClass()) as RotatorItemRenderer;
				items.push( item );

				if (i < dataVOs.length)	// we won't add any data to the last created item - it will be created as a "spare" one
				{
					item.setDataVO( dataVOs[i] );
					addChild( item );
				}
			}

			updateItemsPosition();
		}

		public function pushItemDataVO( dataVO:RotatorItemDataVO, customState:String = "" ):void
		{
			if (isInMotion)
			{
				for (var i:int = 0; i < items.length; i++)
				{
					TweenMax.killTweensOf( items[i] );
				}
				updateItemsPosition();
			}

			var lastItem:RotatorItemRenderer = items[items.length - 1];
			lastItem.setDataVO( dataVO );
			lastItem.init();
			lastItem.fadeIn();
			addChild( lastItem );

			updateItemsPosition();

			items[highlightedItemIndex].unhighlight( customState );
			items[highlightedItemIndex + 1].highlight();

			var firstItem:RotatorItemRenderer = items.shift();
			firstItem.fadeOut();
			items.push( firstItem );

			shift();
		}

		private function shift():void
		{
			for (var i:int = 0; i < items.length; i++)
			{
				TweenMax.to(
						items[i], 5, {
							y: items[i].y - SIZE - SPACING,
							onComplete: function ():void
							{
								isInMotion = false
							}
						}
				);
			}
			isInMotion = true;
		}

		private function updateItemsPosition():void
		{
			var currentY:int = OFFSET;
			for (var i:int = 0; i < items.length; i++)
			{
				items[i].x = 0;
				items[i].y = currentY;

				currentY += SIZE + SPACING;
			}
		}
	}
}
