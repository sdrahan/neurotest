/**
 * Created by sergd on 12/7/2015.
 */
package
{

	public class EmbeddedFonts
	{
		[Embed(source="../assets/OpenSans-Bold.ttf", embedAsCFF="false", fontFamily="OpenSans", fontWeight="bold")]
		private static const OpenSansBold:Class;

		[Embed(source="../assets/OpenSans-Light.ttf", embedAsCFF="false", fontFamily="OpenSans")]
		private static const OpenSans:Class;

		public function EmbeddedFonts()
		{
		}
	}
}
