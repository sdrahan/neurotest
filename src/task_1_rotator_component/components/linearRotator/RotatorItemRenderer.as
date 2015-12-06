package task_1_rotator_component.components.linearRotator
{

	import com.greensock.TweenMax;

	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;

	public class RotatorItemRenderer extends Sprite
	{
		private var data:RotatorItemDataVO;
		private var textField:TextField;

		private var appearance:Quad;

		public function RotatorItemRenderer()
		{
			appearance = new Quad( 100, 40, 0xAABBCCFF );
			appearance.pivotX = 50;
			appearance.pivotY = 20;
			addChild( appearance );

			textField = new TextField( 80, 30, "", "Verdana", 10 );
			textField.x = -40;
			textField.y = -15;
			addChild( textField );
		}

		public function setDataVO( data:RotatorItemDataVO ):void
		{
			this.data = data;
		}

		public function init():void
		{
			textField.text = data.value.toString();
		}

		public function fadeIn():void
		{
			TweenMax.to( appearance, 0.5, {alpha: 1} );
		}

		public function highlight():void
		{
			TweenMax.to( appearance, 0.2, {scaleX: 1.2, scaleY: 1.2} );
		}

		public function unhighlight( customState:String = "" ):void
		{
			TweenMax.killTweensOf(appearance);
			appearance.scaleX = appearance.scaleY = 1;
			if (customState != "")
			{
				textField.text = customState;
			}
		}

		public function fadeOut():void
		{
			TweenMax.to( appearance, 0.5, {alpha: 0} );
		}
	}
}
