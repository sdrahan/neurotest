package task_1_rotator_component
{

	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	import task_1_rotator_component.components.linearRotator.LinearRotator;
	import task_1_rotator_component.components.linearRotator.RotatorItemDataVO;
	import task_1_rotator_component.components.linearRotator.VerticalLinearRotatorLayout;

	public class Task1RotatorComponent extends Sprite
	{
		private var linearRotator:LinearRotator;
		private var yesButton:Button;
		private var noButton:Button;
		private var exitButton:Button;

		public function Task1RotatorComponent()
		{
			createLinearRotator();
			initButtons();
		}

		private function createLinearRotator():void
		{
			linearRotator = new LinearRotator( NeuroRotatorItemRenderer, getInitialItemsVector(), 1, new VerticalLinearRotatorLayout() );
			addChild( linearRotator );
			linearRotator.x = 320;
			linearRotator.y = 100;
		}

		private function getInitialItemsVector():Vector.<RotatorItemDataVO>
		{
			var items:Vector.<RotatorItemDataVO> = new <RotatorItemDataVO>[];
			items.push( new NeuroRotatorItemDataVO( "", true ) );	// first one will be initially blank
			for (var i:int = 1; i < 4; i++)		// we skipped first one, so now we start with 1
			{
				items.push( getRandomRotatorDataVO() );
			}
			return items;
		}

		private function initButtons():void
		{
			var textField:TextField = new TextField( 400, 60, "Is this expression correct?", "OpenSans", 30, 0xFFFFFF );
			textField.x = 120;
			textField.y = 10;
			addChild( textField );

			yesButton = new Button( AssetsManager.instance.getTexture( "button_yes_out" ), "", AssetsManager.instance.getTexture( "button_yes_down" ) );
			yesButton.addEventListener( Event.TRIGGERED, onYesButtonTriggered );
			yesButton.x = 208;
			yesButton.y = 370;
			addChild( yesButton );

			noButton = new Button( AssetsManager.instance.getTexture( "button_no_out" ), "", AssetsManager.instance.getTexture( "button_no_down" ) );
			noButton.addEventListener( Event.TRIGGERED, onNoButtonTriggered );
			noButton.x = 334;
			noButton.y = 370;
			addChild( noButton );

			exitButton = new Button( AssetsManager.instance.getTexture( "button_exit_out" ), "", AssetsManager.instance.getTexture( "button_exit_down" ) );
			exitButton.addEventListener( Event.TRIGGERED, onExitButtonTriggered );
			exitButton.x = 0;
			exitButton.y = 430;
			addChild( exitButton );
		}

		private function onYesButtonTriggered( event:Event ):void
		{
			var customState:String;
			if (NeuroRotatorItemDataVO( linearRotator.getCurrentHighlightedDataVO() ).isCorrect)
			{
				customState = NeuroRotatorItemDataVO.CORRECT;
			}
			else
			{
				customState = NeuroRotatorItemDataVO.WRONG
			}
			linearRotator.pushItemDataVO( getRandomRotatorDataVO(), customState );
		}

		private function onNoButtonTriggered( event:Event ):void
		{
			var customState:String;
			if (NeuroRotatorItemDataVO( linearRotator.getCurrentHighlightedDataVO() ).isCorrect)
			{
				customState = NeuroRotatorItemDataVO.WRONG;
			}
			else
			{
				customState = NeuroRotatorItemDataVO.CORRECT;
			}
			linearRotator.pushItemDataVO( getRandomRotatorDataVO(), customState );
		}

		private function onExitButtonTriggered( event:Event ):void
		{
			cleanUp();
			dispatchEvent( new Event( "Exit" ) );
		}

		private function getRandomRotatorDataVO():NeuroRotatorItemDataVO
		{
			var valueA:int = Math.random() * 10 + 1;
			var valueB:int = Math.random() * 10 + 1;

			var answerIsCorrect:Boolean;
			var text:String;

			if (Math.random() > 0.5)
			{
				// let the answer be correct
				answerIsCorrect = true;
				text = valueA + " + " + valueB + " = " + (valueA + valueB).toString();
			}
			else
			{
				answerIsCorrect = false;
				// following line is just generating something different from the correct answer
				var answerToDisplay:int = (valueA + valueB) + Math.ceil( Math.random() * 5 ) * (Math.random() > 0.5 ? 1 : -1);
				text = valueA + " + " + valueB + " = " + answerToDisplay.toString();
			}

			var dataVO:NeuroRotatorItemDataVO = new NeuroRotatorItemDataVO( text, answerIsCorrect );
			return dataVO;
		}

		private function cleanUp():void
		{
			yesButton.removeEventListener( Event.TRIGGERED, onYesButtonTriggered );
			noButton.removeEventListener( Event.TRIGGERED, onNoButtonTriggered );
			exitButton.removeEventListener( Event.TRIGGERED, onExitButtonTriggered );
		}
	}
}
