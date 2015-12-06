package task_2_array_shuffling
{

	import flash.utils.setTimeout;

	public class Task2ArrayShuffling
	{
		private static var ELEMENTS_COUNT:int = 5000;

		public function Task2ArrayShuffling()
		{
			setTimeout( start, 500 );		// small timeout just so everything is not happening in the constructor
		}

		private function start():void
		{
			trace( "Method 1:" );	// good shuffling method: create another array and put random elements to it from the initial array while splicing it. O(n) solution
			measurePerformance(shuffle1);

			trace( "Method 1 (optimized):" );	// looks like my optimization didn't really gave any boost, most probably compiler already optimized everything
			measurePerformance(shuffle1Optimized);

			trace( "Method 2:" );	// this method is usually one of the most recommended, but in reality it's pretty bad
			measurePerformance(shuffle2);
		}

		private function measurePerformance(shufflingFunction:Function):void
		{
			var initialArray:Array = getInitialArray( ELEMENTS_COUNT );
			var timeAtTheBeginning:Number = (new Date()).time;
			shufflingFunction( initialArray );
			var timeAtTheEnd:Number = (new Date()).time;
			trace( "Time (ms): " + (timeAtTheEnd - timeAtTheBeginning) );
		}

		private function getInitialArray( elementsCount:int ):Array
		{
			var array:Array = [];
			for (var i:int = 1; i <= elementsCount; i++)	// starting from 1 so array will be filled neatly - like [1,2,3]
			{
				array.push( i );
			}
			return array;
		}

		private function shuffle1( initialArray:Array ):void
		{
			var shuffledArray:Array = [];

			while (initialArray.length > 0)
			{
				var index:int = Math.random() * initialArray.length;
				shuffledArray.push( initialArray[index] );
				initialArray.splice( index, 1 );
			}
		}

		private function shuffle1Optimized( initialArray:Array ):void
		{
			var shuffledArray:Array = [];
			var index:int;
			var arrayLength:int = initialArray.length;

			while (arrayLength > 0)
			{
				index = Math.random() * arrayLength;
				shuffledArray.push( initialArray.splice( index, 1 )[0] );
				arrayLength--;
			}
		}

		private function shuffle2( initialArray:Array ):void
		{
			const RANDOM_SORT_STRENGTH:Number = 0.5;
			initialArray.sort( randomSort );

			function randomSort( elementA:int, elementB:int ):Number
			{
				if (Math.random() < RANDOM_SORT_STRENGTH)
				{
					return -1;
				}
				else
				{
					return 0;
				}
			}
		}
	}
}
