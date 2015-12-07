package task_1_rotator_component.components.linearRotator
{

	import flash.geom.Rectangle;

	import starling.display.Sprite;

	public class RotatorItemRenderer extends Sprite
	{
		protected var data:RotatorItemDataVO;

		public function RotatorItemRenderer()
		{
		}

		public function setDataVO( value:RotatorItemDataVO ):void
		{
			data = value;
		}

		public function getDataVO():RotatorItemDataVO
		{
			return data;
		}

		public function init():void
		{
		}

		public function highlight():void
		{
			scaleX = scaleY = 1.2;
		}

		public function unhighlight( customState:String = "" ):void
		{
			scaleX = scaleY = 1;
		}

		public function fadeIn():void
		{
			alpha = 1;
		}

		public function fadeOut():void
		{
			alpha = 0;
		}

		public function getSize():Rectangle
		{
			return new Rectangle( 0, 0, width, height );
		}
	}
}
