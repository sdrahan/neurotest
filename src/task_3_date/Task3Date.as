package task_3_date
{

	import starling.display.Sprite;

	public class Task3Date extends Sprite
	{
		public function Task3Date()
		{
			var d:Date = new Date();
			trace( "raw d.time: " + d.time );

			var ts:Number = d.time - 24 * 60 * 60 * 1000;

			trace( "Before: " + d + ",    " + d.toTimeString() );
			d.time = ts;
			trace( "After: + " + d + ",    " + d.toTimeString() );
		}
	}
}

// 1449401806636
// 2147483647
// 4294967295
