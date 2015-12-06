/**
 * Created by sergd on 12/7/2015.
 */
package task_1_rotator_component
{

	import task_1_rotator_component.components.linearRotator.RotatorItemDataVO;

	public class NeuroRotatorItemDataVO extends RotatorItemDataVO
	{
		public var value:int;

		public function NeuroRotatorItemDataVO( value:int )
		{
			this.value = value;
		}
	}
}
