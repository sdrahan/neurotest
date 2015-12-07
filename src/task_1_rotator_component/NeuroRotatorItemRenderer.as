/**
 * Created by sergd on 12/7/2015.
 */
package task_1_rotator_component
{

	import com.greensock.TweenMax;

	import flash.geom.Rectangle;

	import starling.display.Image;
	import starling.text.TextField;

	import task_1_rotator_component.components.linearRotator.RotatorItemRenderer;

	public class NeuroRotatorItemRenderer extends RotatorItemRenderer
	{
		private var textField:TextField;
		private var appearance:Image;

		private static const FADE_DURATION:Number = 0.3;
		private static const HIGHLIGHT_DURATION:Number = 0.2;
		private static const HIGHLIGHT_SCALE:Number = 1.2;
		private static const DEFAULT_HEIGHT:Number = 45;

		public function NeuroRotatorItemRenderer()
		{
			appearance = new Image( AssetsManager.instance.getTexture( "rotator_bg_neutral" ) );
			appearance.pivotX = appearance.width / 2;
			appearance.pivotY = appearance.height / 2;
			addChild( appearance );

			textField = new TextField( appearance.width, appearance.height, "", "OpenSans", 18, 0x34455B, true );
			textField.x = -appearance.width / 2;
			textField.y = -appearance.height / 2;
			addChild( textField );
		}

		override public function init():void
		{
			var dataVO:NeuroRotatorItemDataVO = data as NeuroRotatorItemDataVO;

			textField.text = dataVO.text;
			appearance.scaleX = appearance.scaleY = 1;
			appearance.texture = AssetsManager.instance.getTexture( "rotator_bg_neutral" );

			// special case for blank item:
			if (dataVO.text == "")
			{
				textField.visible = false;
				appearance.visible = false;
			}
			else
			{
				textField.visible = true;
				appearance.visible = true;
			}
		}

		override public function highlight():void
		{
			TweenMax.killTweensOf( appearance );
			TweenMax.to( appearance, HIGHLIGHT_DURATION, {scaleX: HIGHLIGHT_SCALE, scaleY: HIGHLIGHT_SCALE} );
		}

		override public function unhighlight( customState:String = "" ):void
		{
			TweenMax.killTweensOf( appearance );
			TweenMax.to( appearance, HIGHLIGHT_DURATION, {scaleX: 1, scaleY: 1} );
			if (customState == NeuroRotatorItemDataVO.CORRECT)
			{
				textField.text = "Correct!";
				appearance.texture = AssetsManager.instance.getTexture( "rotator_bg_correct" );
			}
			else if (customState == NeuroRotatorItemDataVO.WRONG)
			{
				textField.text = "Wrong";
				appearance.texture = AssetsManager.instance.getTexture( "rotator_bg_wrong" );
			}
		}

		override public function fadeIn():void
		{
			TweenMax.to( appearance, FADE_DURATION, {alpha: 1} );
			TweenMax.to( textField, FADE_DURATION, {alpha: 1} );
		}

		override public function fadeOut():void
		{
			TweenMax.to( appearance, FADE_DURATION, {alpha: 0} );
			TweenMax.to( textField, FADE_DURATION, {alpha: 0} );
		}

		override public function getSize():Rectangle
		{
			return new Rectangle( 0, 0, width, DEFAULT_HEIGHT );
		}
	}
}
