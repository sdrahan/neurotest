/**
 * Created by sergd on 12/7/2015.
 */
package
{

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class MainMenu extends Sprite
	{
		private var appearance:MainMenu_appearance;

		public static const TASK_1:String = "Task1";
		public static const TASK_4:String = "Task4";
		public static const TASK_5:String = "Task5";
		public static const TASK_5_RT:String = "Task5RT";

		public function MainMenu()
		{
			appearance = new MainMenu_appearance();
			addChild( appearance );

			appearance.btnTask1.addEventListener( MouseEvent.CLICK, onBtnTask1Click );
			appearance.btnTask4.addEventListener( MouseEvent.CLICK, onBtnTask4Click );
			appearance.btnTask5.addEventListener( MouseEvent.CLICK, onBtnTask5Click );
			appearance.btnTask5rt.addEventListener( MouseEvent.CLICK, onBtnTask5RTClick );
		}

		private function onBtnTask1Click( event:MouseEvent ):void
		{
			dispatchEvent( new Event( TASK_1 ) );
		}

		private function onBtnTask4Click( event:MouseEvent ):void
		{
			dispatchEvent( new Event( TASK_4 ) );
		}

		private function onBtnTask5Click( event:MouseEvent ):void
		{
			dispatchEvent( new Event( TASK_5 ) );
		}

		private function onBtnTask5RTClick( event:MouseEvent ):void
		{
			dispatchEvent( new Event( TASK_5_RT ) );
		}
	}
}
