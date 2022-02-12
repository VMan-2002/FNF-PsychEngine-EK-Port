package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

using StringTools;

class StrumNote extends FlxSprite {
	private var colorSwap:ColorSwap;
	public var resetAnim:Float = 0;
	private var noteData:Int = 0;
	public var direction:Float = 90;//plan on doing scroll directions soon -bb

	private var player:Int;

	public var texture(default, set):String = null;
	private function set_texture(value:String):String {
		if(texture != value) {
			texture = value;
			reloadNote();
		}
		return value;
	}

	/*public var HitTypeNote:StrumNoteTypeHit = null;
	override function set_visible(value:Bool):Bool {
		if(visible != value) {
			if (HitTypeNote != null && HitTypeNote.NType_active)
				HitTypeNote.visible = value;
			else
				visible = value;
		}
		return super.set_visible(visible);
	}
	
	private function get_visible():Bool {
		if(HitTypeNote.NType_active)
			return HitTypeNote.visible;
		return visible;
	}*/

	public static var maniaSwitchPositions:Array<Dynamic> = [
        [0, 1, 2, 3, "alpha0", "alpha0", "alpha0", "alpha0", "alpha0"],
        [0, 4, 1, 2, "alpha0", 3, "alpha0", "alpha0", 5],
        [0, 1, 2, 3, 4, 5, 6, 7, 8],
        [0, 1, 3, 4, 2, "alpha0", "alpha0", "alpha0", "alpha0"],
        [0, 5, 1, 2, 3, 4, "alpha0", "alpha0", 6],
        [0, 1, 2, 3, "alpha0", 4, 5, 6, 7],
        ["alpha0", "alpha0", "alpha0", "alpha0", 0, "alpha0", "alpha0", "alpha0", "alpha0"],
        [0, "alpha0", "alpha0", 1, "alpha0", "alpha0", "alpha0", "alpha0", "alpha0"],
        [0, "alpha0", "alpha0", 2, 1, "alpha0", "alpha0", "alpha0", "alpha0"]
    ];

	public var defaultWidth:Float;
	public var defaultY:Float;
	public var defaultX:Float;

	public function new(x:Float, y:Float, leData:Int, player:Int) {
		colorSwap = new ColorSwap();
		shader = colorSwap.shader;
		noteData = leData;
		this.player = player;
		this.noteData = leData;
		super(x, y);

		var skin:String = 'NOTE_assets';
		if(PlayState.SONG.arrowSkin != null && PlayState.SONG.arrowSkin.length > 1) skin = PlayState.SONG.arrowSkin;
		texture = skin; //Load texture and anims

		scrollFactor.set();
		
		ManiaInfo.DoNoteSpecial(this, noteData, PlayState.CurManiaInfo);
		
		/*if (!PlayState.isPixelStage) {
			HitTypeNote = new StrumNoteTypeHit(this, noteData);
			FlxG.state.add(HitTypeNote);
		}*/
	}

	public function reloadNote() {
		var lastAnim:String = null;
		if(animation.curAnim != null) lastAnim = animation.curAnim.name;

		if(PlayState.isPixelStage) {
			loadGraphic(Paths.image('pixelUI/' + texture));
			width = width / ManiaInfo.PixelNoteSheetWide;
			height = height / 9;
			loadGraphic(Paths.image('pixelUI/' + texture), true, Math.floor(width), Math.floor(height));
			/*animation.add('green', [11]);
			animation.add('red', [12]);
			animation.add('blue', [10]);
			animation.add('purplel', [9]);

			animation.add('white', [13]);
			animation.add('yellow', [14]);
			animation.add('violet', [15]);
			animation.add('black', [16]);
			animation.add('darkred', [16]);
			animation.add('orange', [16]);
			animation.add('dark', [17]);*/
			
			var arrnames:Array<String> = PlayState.CurManiaInfo.arrows;
			var numberwide:Int = ManiaInfo.PixelNoteSheetWide;
			
			var pixelMyNote = ManiaInfo.PixelArrowNum[arrnames[noteData]];
			var framedown:Array<Int> = [
				for (v in CoolUtil.numberArray(9)) {
					v = (v * numberwide) + pixelMyNote;
				}
			];
			defaultWidth = width;
			setGraphicSize(Std.int(width * PlayState.daPixelZoom * Note.pixelnoteScale));
			updateHitbox();
			antialiasing = false;
			animation.add('static', [framedown[0]]);
			animation.add('pressed', [framedown[1], framedown[2]], 12, false);
			animation.add('confirm', [framedown[3], framedown[4]], 24, false);
			animation.add('pixelFadeIn', [framedown[5], framedown[6], framedown[7], framedown[7], framedown[8], framedown[8], framedown[0]], 18, false);
		} else {
			frames = Paths.getSparrowAtlas(texture);
			
			var pPre = PlayState.CurManiaInfo.arrows[noteData];
			var nSuf = ManiaInfo.StrumlineArrow[pPre];

			antialiasing = ClientPrefs.globalAntialiasing;
			defaultWidth = width;
			setGraphicSize(Std.int(width * Note.noteScale));

			animation.addByPrefix('static', 'arrow' + nSuf);
			animation.addByPrefix('pressed', pPre + ' press', 24, false);
			animation.addByPrefix('confirm', pPre + ' confirm', 24, false);
		}

		updateHitbox();

		if(lastAnim != null) {
			playAnim(lastAnim, true);
		}
	}

	public function postAddedToGroup() {
		playAnim('static');
		x += Note.swagWidth * noteData;
		x += 50;
		x += ((FlxG.width / 2) * player) - Note.posRest[Note.mania];
		ID = noteData;
		defaultX = this.x;
		defaultY = this.y;
	}

	override function update(elapsed:Float) {
		if(resetAnim > 0) {
			resetAnim -= elapsed;
			if(resetAnim <= 0) {
				playAnim('static');
				resetAnim = 0;
			}
		}
		
		/*if(animation.curAnim.name == 'confirm' && !PlayState.isPixelStage) {
			centerOrigin();
		}*/

		super.update(elapsed);
	}

	public function playAnim(anim:String, ?force:Bool = false) {
		animation.play(anim, force);
		centerOffsets();
		centerOrigin();
		var colornum:Int = ManiaInfo.getReal[PlayState.CurManiaInfo.arrows[noteData % PlayState.CurManiaInfo.keys]];
		if(animation.curAnim == null || animation.curAnim.name == 'static' || animation.curAnim.name == 'pixelFadeIn') {
			colorSwap.hue = 0;
			colorSwap.saturation = 0;
			colorSwap.brightness = 0;
			/*if (HitTypeNote != null && HitTypeNote.NType_active) {
				HitTypeNote.NType_active = false;
			}*/
		} else {
			if (colornum != -1) {
				colorSwap.hue = ClientPrefs.arrowHSV[colornum][0] / 360;
				colorSwap.saturation = ClientPrefs.arrowHSV[colornum][1] / 100;
				colorSwap.brightness = ClientPrefs.arrowHSV[colornum][2] / 100;
			}
			/*if (anim == 'confirm' && HitTypeNote != null && HitTypeNote.texture != texture) {
				HitTypeNote.NType_active = true;
			}*/
		}
	}
	
	public function moveKeyPositions(spr:FlxSprite, newMania:Int, playe:Int):Void {
		spr.x = ClientPrefs.middleScroll ? PlayState.STRUM_X_MIDDLESCROLL : PlayState.STRUM_X;
		
		spr.alpha = 1;
		
		if (maniaSwitchPositions[newMania][spr.ID] == "alpha0") {
			spr.alpha = 0;
		} else {
			spr.x += Note.noteWidths[newMania] * maniaSwitchPositions[newMania][spr.ID];
		}
			
		spr.x += 50;
		spr.x += ((FlxG.width / 2) * playe);
		spr.x -= Note.posRest[newMania];

		defaultX = spr.x;
	}
	
	override function destroy() {
		//StrumNoteTypeHit.destroy(); //why it dont work
		super.destroy();
	}
}
