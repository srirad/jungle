package jungle
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author Srini
	 */
	public class GetAssets
	{
		
		//	[Embed(source = "Media/Art/Images/bg.png")]
		[Embed(source="Assets/bg.png")]
		public static const bg:Class;
		
		[Embed(source="Assets/cloud.png")]
		public static const cloud:Class;
		
		
		[Embed(source = "Assets/spritesheet.xml", mimeType = "application/octet-stream")]
		public static const AtlasXmlDeer:Class;
		
		[Embed(source = "Assets/spritesheet.png")]
		public static const AtlasTextureDeer:Class;
		
		
		[Embed(source="/../embed/Hero.xml", mimeType="application/octet-stream")]
		public static const _heroConfig:Class;
		
		[Embed(source="/../embed/Hero.png")]
		public static const _heroPng:Class;
		
		private static var gameTextureAtlas:TextureAtlas;
		
		private static var gameTexture:Dictionary = new Dictionary();
		
		public static function getTexture(name:String):Texture
		{
			if (gameTexture[name] == undefined)
			{
				var bitmap:Bitmap = new GetAssets[name]();
				gameTexture[name] = Texture.fromBitmap(bitmap);
			}
			return gameTexture[name];
		}
		
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureDeer");
				var xml:XML = XML(new AtlasXmlDeer());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			
			return gameTextureAtlas;
		}
		
		
		public static function getHeroAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("_heroPng");
				var xml:XML = XML(new _heroConfig());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			
			return gameTextureAtlas;
		}
	
	}
}