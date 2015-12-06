package
{

	public class EmbeddedAtlas
	{
		[Embed(source="../assets/neurotexture.xml", mimeType="application/octet-stream")]
		public static const neurotexture_XML:Class;

		[Embed(source="../assets/neurotexture.png")]
		public static const neurotexture:Class;

		public function EmbeddedAtlas()
		{
		}
	}
}
