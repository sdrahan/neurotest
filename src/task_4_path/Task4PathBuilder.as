/**
 * Created by sergd on 12/7/2015.
 */
package task_4_path
{

	import com.greensock.TweenMax;

	import flash.geom.Point;

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Task4PathBuilder extends Sprite
	{
		private var exitButton:Button;
		private var repeatButton:Button;

		private var gridVector:Vector.<Vector.<int>>;
		private var quads:Vector.<Vector.<Quad>>;
		private var path:Vector.<Point>;

		private var cellWidth:int;
		private var cellHeight:int;

		private var dotsAmount:int = 8;
		private var gridWidth:int = 5;
		private var gridHeight:int = 3;

		private static const DELAY:Number = 0.6;
		private static const TWEEN_DURATION:Number = 0.3;
		private static const DOT_RADIUS:Number = 16;

		public function Task4PathBuilder()
		{
			init();
		}

		private function init():void
		{
			initVectors();
			initGrid();
			makePath();
			displayDots();
			addButtons();
		}

		public function initVectors():void
		{
			gridVector = new <Vector.<int>>[];
			quads = new <Vector.<Quad>>[];
		}

		private function initGrid():void
		{
			gridWidth = int( Math.random() * 3 ) + 4;
			gridHeight = int( Math.random() * 2 ) + 2;
			dotsAmount = int( Math.random() * 4 ) + 4;
			if (dotsAmount > gridHeight * gridWidth)
			{
				dotsAmount = gridHeight * gridWidth;
			}

			cellWidth = 640 / gridWidth;
			cellHeight = 480 / gridHeight;

			for (var currentX:int = 0; currentX < gridWidth; currentX++)
			{
				gridVector[currentX] = new <int>[];
				quads[currentX] = new <Quad>[];
				for (var currentY:int = 0; currentY < gridHeight; currentY++)
				{
					gridVector[currentX][currentY] = 0;

					// also we'll show multicoloured quads to make it more illustrative
					var quad:Quad = new Quad( cellWidth, cellHeight, Math.random() * 0xFFFFFF );
					quad.x = cellWidth * currentX;
					quad.y = cellHeight * currentY;
					addChild( quad );
					quads[currentX][currentY] = quad;
				}
			}
		}

		private function makePath():void
		{
			path = new <Point>[];
			var counter:int = dotsAmount;
			var currentPosition:Point = getRandomFreeCell();
			while (counter > 0 && currentPosition != null)
			{
				markPosition( currentPosition );
				var pointsToTry:Vector.<Point> = getSurroundingCells( currentPosition );
				var nextPosition:Point = randomlySelectNextPoint( pointsToTry );
				if (nextPosition == null) // no more free adjacent cells
				{
					nextPosition = getRandomFreeCell();
				}

				if (nextPosition == null) // oh no! that means there are no more free cells
				{
					break;
				}
				currentPosition = nextPosition;
				counter--;
			}
		}

		private function getRandomFreeCell():Point
		{
			var freeCells:Vector.<Point> = new <Point>[];
			for (var currentX:int = 0; currentX < gridVector.length; currentX++)
			{
				for (var currentY:int = 0; currentY < gridVector[0].length; currentY++)
				{
					if (gridVector[currentX][currentY] == 0)
					{
						freeCells.push( new Point( currentX, currentY ) );
					}
				}
			}
			if (freeCells.length == 0)
			{
				return null;
			}
			return freeCells[int( Math.random() * freeCells.length )];
		}

		private function markPosition( currentPosition:Point ):void
		{
			trace( "markingPosition " + currentPosition );
			gridVector[currentPosition.x][currentPosition.y] = 1;
			var quad:Quad = quads[currentPosition.x][currentPosition.y];
			TweenMax.to( quad, TWEEN_DURATION, {alpha: 0, delay: DELAY * path.length} );
//			quads[currentPosition.x][currentPosition.y].visible = false;
			path.push( currentPosition.clone() );
		}

		private function getSurroundingCells( currentPosition:Point ):Vector.<Point>
		{
			var pointsToTry:Vector.<Point> = new <Point>[];

			if (currentPosition.x < gridVector.length - 1)
			{
				pointsToTry.push( new Point( currentPosition.x + 1, currentPosition.y ) );
			}

			if (currentPosition.x > 0)
			{
				pointsToTry.push( new Point( currentPosition.x - 1, currentPosition.y ) );
			}

			if (currentPosition.y < gridVector[0].length - 1)
			{
				pointsToTry.push( new Point( currentPosition.x, currentPosition.y + 1 ) );
			}

			if (currentPosition.y > 0)
			{
				pointsToTry.push( new Point( currentPosition.x, currentPosition.y - 1 ) );
			}

			return pointsToTry;
		}

		private function randomlySelectNextPoint( pointsToTry:Vector.<Point> ):Point
		{
			var randomlyChosenPoint:Point;

			while (pointsToTry.length > 0)
			{
				randomlyChosenPoint = pointsToTry.splice( int( Math.random() * pointsToTry.length ), 1 )[0];

				if (gridVector[randomlyChosenPoint.x][randomlyChosenPoint.y] == 0)
				{
					return randomlyChosenPoint;
				}
			}

			trace( "Couldn't find free adjacent cell" );
			return null;
		}

		private function displayDots():void
		{
			var initialDelay:Number = path.length * DELAY;
			var dots:Vector.<Point> = new <Point>[];
			for (var i:int = 0; i < path.length; i++)
			{
				var cellCoords:Point = path[i];
				var dot:Image = new Image( AssetsManager.instance.getTexture( "circle" ) );
				dot.pivotX = dot.width / 2;
				dot.pivotY = dot.height / 2;

				var leftBoundary:int = cellWidth * cellCoords.x;
				var topBoundary:int = cellHeight * cellCoords.y;
				dot.x = leftBoundary + DOT_RADIUS + Math.random() * (cellWidth - DOT_RADIUS);
				dot.y = topBoundary + DOT_RADIUS + Math.random() * (cellHeight - DOT_RADIUS);

				addChild( dot );
				dot.alpha = 0;
				dot.scaleX = dot.scaleY = 0.1;
				TweenMax.to( dot, TWEEN_DURATION, {alpha: 1, scaleX: 1, scaleY: 1, delay: i * DELAY + initialDelay} );
			}
		}

		private function addButtons():void
		{
			exitButton = new Button( AssetsManager.instance.getTexture( "button_exit_out" ), "", AssetsManager.instance.getTexture( "button_exit_down" ) );
			exitButton.addEventListener( Event.TRIGGERED, onExitButtonTriggered );
			exitButton.x = 0;
			exitButton.y = 430;
			addChild( exitButton );

			repeatButton = new Button( AssetsManager.instance.getTexture( "button_repeat_out" ), "", AssetsManager.instance.getTexture( "button_repeat_down" ) );
			repeatButton.addEventListener( Event.TRIGGERED, onRepeatButtonTriggered );
			repeatButton.x = 540;
			repeatButton.y = 430;
			addChild( repeatButton );
		}

		private function onRepeatButtonTriggered( event:Event ):void
		{
			cleanUp();
			init();
		}

		private function onExitButtonTriggered( event:Event ):void
		{
			cleanUp();
			dispatchEvent( new Event( "Exit" ) );
		}

		private function cleanUp():void
		{
			TweenMax.killAll();
			removeChildren();
			exitButton.removeEventListener( Event.TRIGGERED, onExitButtonTriggered );
			repeatButton.removeEventListener( Event.TRIGGERED, onRepeatButtonTriggered );
		}
	}
}
