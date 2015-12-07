/**
 * Created by sergd on 12/7/2015.
 */
package task_1_rotator_component
{

	import task_1_rotator_component.components.linearRotator.RotatorItemDataVO;

	public class NeuroRotatorItemDataVO extends RotatorItemDataVO
	{
		public var text:String;
		public var isCorrect:Boolean;

		public static const CORRECT:String = "Correct";
		public static const WRONG:String = "Wrong";

		public function NeuroRotatorItemDataVO( text:String, isCorrect:Boolean )
		{
			this.text = text;
			this.isCorrect = isCorrect;
		}
	}
}
