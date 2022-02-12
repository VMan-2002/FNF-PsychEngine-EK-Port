package;

import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	public var char:String = '';

	public function new(char:String = 'bf', isPlayer:Bool = false) {
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	public function swapOldIcon() {
		if(isOldIcon = !isOldIcon) changeIcon('bf-old');
		else changeIcon('bf');
	}

	private var iconOffsets:Array<Float> = [0, 0];
	public function changeIcon(char:String) {
		if(this.char != char) {
			var name:String = 'icons/' + char;
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
			if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon
			var file:Dynamic = Paths.image(name);

			loadGraphic(file);
			var ratio:Float = width / height; //lol
			//trace('ratio for $char is $ratio');
			if (ratio > 2.5) {
				//theres a winning icon
				loadGraphic(file, true, Math.floor(width / 3), Math.floor(height));
				animation.add(char, [0, 1, 2], 0, false, isPlayer);
				//trace(char+" has win icon");
			} else if (ratio < 1.5) {
				//theres no losing icon
				loadGraphic(file, true, Math.floor(width), Math.floor(height));
				animation.add(char, [0, 0, 0], 0, false, isPlayer);
				//trace(char+" has single icon");
			} else {
				//there is 2 icon
				loadGraphic(file, true, Math.floor(width / 2), Math.floor(height));
				animation.add(char, [0, 1, 0], 0, false, isPlayer);
				//trace(char+" has normal icon");
			}
			iconOffsets[0] = (width - 150) / 2;
			iconOffsets[1] = (width - 150) / 2;
			updateHitbox();
			
			animation.play(char);
			this.char = char;

			antialiasing = ClientPrefs.globalAntialiasing;
			if(char.endsWith('-pixel')) {
				antialiasing = false;
			}
		}
	}

	override function updateHitbox()
	{
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}

	public function getCharacter():String {
		return char;
	}
}
