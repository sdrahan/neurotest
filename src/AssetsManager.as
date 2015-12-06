/**
 * Created by sergd on 12/6/2015.
 */
package
{

	import starling.textures.Texture;
	import starling.utils.AssetManager;

	public class AssetsManager
	{
		private var starlingAssetManager:AssetManager;

		private static var _instance:AssetsManager;

		public function AssetsManager()
		{
		}

		public function setStarlingAssrtManager( starlingAssetManager:AssetManager ):void
		{
			this.starlingAssetManager = starlingAssetManager;
		}

		public function getTexture( name:String ):Texture
		{
			return starlingAssetManager.getTexture( name );
		}

		public static function get instance():AssetsManager
		{
			if (_instance == null)
			{
				_instance = new AssetsManager();
			}
			return _instance;
		}
	}
}
