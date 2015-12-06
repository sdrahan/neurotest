/**
 * Created by sergd on 12/7/2015.
 */
package task_1_rotator_component
{

	import com.greensock.TweenMax;

	import flash.geom.Rectangle;

	import starling.display.Quad;
	import starling.text.TextField;

	import task_1_rotator_component.components.linearRotator.RotatorItemRenderer;

	public class NeuroRotatorItemRenderer extends RotatorItemRenderer
	{
		private var textField:TextField;
		private var appearance:Quad;

		public function NeuroRotatorItemRenderer()
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

		override public function init():void
		{
			textField.text = (data as NeuroRotatorItemDataVO).value.toString();
		}

		override public function fadeIn():void
		{
			TweenMax.to( appearance, 0.5, {alpha: 1} );
		}

		override public function highlight():void
		{
			var targetScale:Number = 1.2;
			TweenMax.to( appearance, 0.2, {scaleX: targetScale, scaleY: targetScale} );
		}

		override public function unhighlight( customState:String = "" ):void
		{
			TweenMax.killTweensOf( appearance );
			appearance.scaleX = appearance.scaleY = 1;
			if (customState != "")
			{
				textField.text = customState;
			}
		}

		override public function fadeOut():void
		{
			TweenMax.to( appearance, 0.5, {alpha: 0} );
		}

		override public function getSize():Rectangle
		{
			return new Rectangle( 0, 0, width, 40 );
		}
	}
}
