package task_2_array_shuffling
{

	import flash.utils.setTimeout;

	public class Task2ArrayShuffling
	{
		public function Task2ArrayShuffling()
		{
			setTimeout( start, 2000 );
		}

		private function start():void
		{
			var timeAtTheBeginning:Number;
			var timeAtTheEnd:Number;
			var elementsCount:int = 100000;

			trace( "Method 1:" );
			var initialArray:Array = getInitialArray( elementsCount );
			timeAtTheBeginning = (new Date()).time;
			shuffle1( initialArray );
			timeAtTheEnd = (new Date()).time;
			trace( "Time (ms): " + (timeAtTheEnd - timeAtTheBeginning) );

			trace( "Method 1 (optimized):" );
			var initialArray:Array = getInitialArray( elementsCount );
			timeAtTheBeginning = (new Date()).time;
			shuffle1Optimized( initialArray );
			timeAtTheEnd = (new Date()).time;
			trace( "Time (ms): " + (timeAtTheEnd - timeAtTheBeginning) );

			trace( "Method 2:" );
			var initialArray:Array = getInitialArray( elementsCount );
			timeAtTheBeginning = (new Date()).time;
			shuffle2( initialArray );
			timeAtTheEnd = (new Date()).time;
			trace( "Time (ms): " + (timeAtTheEnd - timeAtTheBeginning) );
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
//			trace( initialArray, shuffledArray );
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
//			trace( shuffledArray );
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

//			trace( initialArray );
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
	}
}
