package task_3_date
{

	import starling.display.Sprite;

	public class Task3Date extends Sprite
	{
		public function Task3Date()
		{
			var d:Date = new Date();
			/*
			var ts:int = d.time - 24 * 60 * 60 * 1000;
			Oh, question with a trick!
			Range of int is not sufficient to store milliseconds since 1970, so we should use Number instead
			*/
			var ts:Number = d.time - 24 * 60 * 60 * 1000;
			trace( "Before: " + d.toTimeString() );
			d.time = ts;
			trace( "After: " + d.toTimeString() ); // gives us current time minus one day
		}
	}
}