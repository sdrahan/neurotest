package task_1_rotator_component
{

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;

	import task_1_rotator_component.components.linearRotator.LinearRotator;
	import task_1_rotator_component.components.linearRotator.RotatorItemRenderer;
	import task_1_rotator_component.components.linearRotator.RotatorItemDataVO;

	public class Task1RotatorComponent extends Sprite
	{
		private var linearRotator:LinearRotator;

		public function Task1RotatorComponent()
		{
			linearRotator = new LinearRotator(
					RotatorItemRenderer,
					new <RotatorItemDataVO>[new RotatorItemDataVO(1), new RotatorItemDataVO(2), new RotatorItemDataVO(3), new RotatorItemDataVO(4)],
					1
			);
			addChild(linearRotator);
			linearRotator.x = linearRotator.y = 100;

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage( event:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}

		private function onKeyDown( event:KeyboardEvent ):void
		{
			linearRotator.pushItemDataVO(new RotatorItemDataVO(Math.floor(Math.random() * 100)))
		}
	}
}
