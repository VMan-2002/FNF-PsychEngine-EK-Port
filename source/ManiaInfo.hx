package;

import lime.utils.Assets;
import Controls;
import Math;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import ClientPrefs;

using StringTools;

typedef SwagMania = {
	var keys:Int;
	var arrows:Array<String>;
	var controls:Array<String>;
	var arrowkeys:Map<Int, Int>;
	var special:Bool;
	var specialTag:String;
	var control_set:Null<Array<Array<Int>>>;
	/* // for unhardcoded
	var scale:Null<Float>;
	var spacing:Null<Float>;
	*/
}

class ManiaInfo {
	public static var StrumlineArrow:Map<String, String> = [
		'purple' => "LEFT",
		'blue' => "DOWN",
		'green' => "UP",
		'red' => "RIGHT",
		'white' => "SPACE",
		'yellow' => "LEFT",
		'violet' => "DOWN",
		'darkred' => "UP",
		'dark' => "RIGHT",
		'21la' => "TRILEFT",
		'21lb' => "TRIUP",
		'21lc' => "TRIRIGHT",
		'21ld' => "TRILEFT",
		'21le' => "TRIDOWN",
		'21lf' => "TRIRIGHT",
		'21ra' => "TRILEFT",
		'21rb' => "TRIUP",
		'21rc' => "TRIRIGHT",
		'21rd' => "TRILEFT",
		'21re' => "TRIDOWN",
		'21rf' => "TRIRIGHT",
		'13a' => "TRILEFT",
		'13b' => "TRIDOWN",
		'13c' => "TRIUP",
		'13d' => "TRIRIGHT",
		'piano1k' => "PIANOLEFT",
		'piano2k' => "PIANOMID",
		'piano3k' => "PIANORIGHT",
		'piano4k' => "PIANOLEFT",
		'piano5k' => "PIANOMID",
		'piano6k' => "PIANOMID",
		'piano7k' => "PIANORIGHT",
		'piano8k' => "PIANOZERO",
		'pianoblack' => "PIANOBLACK"
	];
	
	public static var PixelArrowNum:Map<String, Int> = [ //used for something?
		'purple' => 0,
		'blue' => 1,
		'green' => 2,
		'red' => 3,
		'white' => 4,
		'yellow' => 5,
		'violet' => 6,
		'darkred' => 7,
		'dark' => 8,
		'13a' => 9,
		'13b' => 10,
		'13c' => 11,
		'13d' => 12,
		'piano1k' => 0,
		'piano2k' => 1,
		'piano3k' => 2,
		'piano4k' => 3,
		'piano5k' => 10,
		'piano6k' => 11,
		'piano7k' => 5,
		'piano8k' => 6,
		'piano9k' => 7,
		'pianoblack' => 8
	];
	
	public static var PixelNoteSheetWide:Int = 13; //this one is used
	
	public static var PixelArrowTypeNum:Map<String, Int> = [ //not actually used yet
		'purple' => 0,
		'blue' => 1,
		'green' => 2,
		'red' => 3,
		'white' => 4,
		'yellow' => 0,
		'violet' => 1,
		'darkred' => 2,
		'dark' => 3,
		'13a' => 5,
		'13b' => 6,
		'13c' => 7,
		'13d' => 8,
		'piano1k' => 0,
		'piano2k' => 1,
		'piano3k' => 2,
		'piano4k' => 3,
		'piano5k' => 10,
		'piano6k' => 11,
		'piano7k' => 5,
		'piano8k' => 6,
		'piano9k' => 7,
		'pianoblack' => 8
	];
	
	public static var PixelNoteTypeSheetWide:Int = 9; //also now actually used yet
	
	public static var Dir:Map<String, String> = [
		'purple' => "LEFT",
		'blue' => "DOWN",
		'green' => "UP",
		'red' => "RIGHT",
		'white' => "UP",
		'yellow' => "LEFT",
		'violet' => "DOWN",
		'darkred' => "UP",
		'dark' => "RIGHT",
		'13a' => "LEFT",
		'13b' => "DOWN",
		'13c' => "UP",
		'13d' => "RIGHT",
		'piano1k' => "LEFT",
		'piano2k' => "DOWN",
		'piano3k' => "RIGHT",
		'piano4k' => "LEFT",
		'piano5k' => "DOWN",
		'piano6k' => "RIGHT",
		'piano7k' => "LEFT",
		'piano8k' => "RIGHT",
		'piano9k' => "UP",
		'pianoblack' => "UP"
	];
	
	public static var BfDir:Map<String, String> = [
		'purple' => "LEFT",
		'blue' => "DOWN",
		'green' => "UP",
		'red' => "RIGHT",
		'white' => "Hey",
		'yellow' => "LEFT",
		'violet' => "DOWN",
		'darkred' => "UP",
		'dark' => "RIGHT",
		'19a' => "LEFT",
		'19b' => "DOWN",
		'19c' => "UP",
		'19d' => "RIGHT",
		'piano1k' => "LEFT",
		'piano2k' => "DOWN",
		'piano3k' => "RIGHT",
		'piano4k' => "LEFT",
		'piano5k' => "DOWN",
		'piano6k' => "RIGHT",
		'piano7k' => "LEFT",
		'piano8k' => "RIGHT",
		'piano9k' => "UP",
		'pianoblack' => "Hey"
	];
	
	public static var getReal:Map<String, Int> = [
		'purple' => 0,
		'blue' => 1,
		'green' => 2,
		'red' => 3,
		'white' => 4,
		'yellow' => 5,
		'violet' => 6,
		'darkred' => 7,
		'dark' => 8,
		'19a' => -1,
		'19b' => -1,
		'19c' => -1,
		'19d' => -1,
		'piano1k' => 0,
		'piano2k' => 1,
		'piano3k' => 2,
		'piano4k' => 3,
		'piano5k' => 5,
		'piano6k' => 6,
		'piano7k' => 7,
		'piano8k' => 8,
		'pianoblack' => 4
	];
	
	public static var AvailableMania:Array<Int> = [ //for chart editor
		6, //1k
		7, //2k
		8, //3k
		0, //4k
		3, //5k
		1, //6k
		4, //7k
		5, //8k
		2, //9k
		27, //10k
		28, //11k
		21, //12k
		20, //13k
		//27, //14k
		//28, //15k
		//29, //16k
		//30, //17k
		//31, //18k
		23, //19k
		//32, //20k
		22, //21k
		24, //50k
		25, //Piano
		26 //105
	];
	
	public static var ManiaConvert:Map<Int, String> = [ //for upcoming unhardcoded manias holy shit
		6 => "1k", //1k
		7 => "2k", //2k
		8 => "3k", //3k
		0 => "4k", //4k
		3 => "5k", //5k
		1 => "6k", //6k
		4 => "7k", //7k
		5 => "8k", //8k
		2 => "9k", //9k
		27 => "10k", //10k
		28 => "11k", //11k
		//25 => "10k", //10k
		//26 => "11k", //11k
		21 => "12k", //12k
		20 => "13k", //13k
		//27 => "14k", //14k
		//28 => "15k", //15k
		//29 => "16k", //16k
		//30 => "17k", //17k
		//31 => "18k", //18k
		23 => "19k", //19k
		//32 => "20k", //20k
		22 => "21k", //21k
		24 => "50k", //50k
		25 => "piano", //Piano
		26 => "105k" //105
	];
	
	public static function GetManiaInfo(mania:Int):SwagMania
	{
		trace('Accessed ManiaInfo for '+mania);
		var mi:SwagMania = {
			keys: 0, //it'll cause the game to Fucking Die but whatever
			arrows: ['purple'], //these still have to count as the correct data type
			controls: ["note_left"],
			arrowkeys: [-1 => 0],
			special: false,
			specialTag: "",
			control_set: null
		}
		switch(mania) {
			case 0: //4K
			mi = {
				keys: 4,
				arrows: ['purple', 'blue', 'green', 'red'],
				controls: ["note_left", "note_down", "note_up", "note_right"], //Controls in ManiaInfo are Unused Lol
				arrowkeys: [37 => 0, 40 => 1, 38 => 2, 39 => 3],
				special: false,
				specialTag: "",
				control_set: null
			};
			case 1: //6K
			mi = {
				keys: 6,
				arrows: ['purple', 'green', 'red', 'yellow', 'blue', 'dark'], //apparently that causes crashing as well
				controls: ["6k0", "6k1", "6k2", "6k4", "6k5", "6k6"],
				arrowkeys: [37 => 3, 40 => 4, 39 => 5],
				special: false,
				specialTag: "",
				control_set: null
			};
			case 2: //9K
			mi = {
				keys: 9,
				arrows: ['purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark'],
				controls: ["9k0", "9k1", "9k2", "9k3", "9k4", "9k5", "9k6", "9k7", "9k8"],
				arrowkeys: [37 => 5, 40 => 6, 38 => 7, 39 => 8],
				special: false,
				specialTag: "",
				control_set: null
			};
			case 3: //5K
			mi = {
				keys: 5,
				arrows: ['purple', 'blue', 'white', 'green', 'red'],
				controls: ["note_left", "note_down", "6k3", "note_up", "note_right"],
				arrowkeys: [37 => 0, 40 => 1, 38 => 3, 39 => 4],
				special: false,
				specialTag: "",
				control_set: null
			};
			case 4: //7K
			mi = {
				keys: 7,
				arrows: ['purple', 'green', 'red', 'white', 'yellow', 'blue', 'dark'],
				controls: ["6k0", "6k1", "6k2", "6k3", "6k4", "6k5", "6k6"],
				arrowkeys: [37 => 4, 40 => 5, 39 => 6],
				special: false,
				specialTag: "",
				control_set: null
			};
			case 5: //8K
			mi = {
				keys: 8,
				arrows: ['purple', 'blue', 'green', 'red', 'yellow', 'violet', 'darkred', 'dark'],
				controls: ["9k0", "9k1", "9k2", "9k3", "9k5", "9k6", "9k7", "9k8"],
				arrowkeys: [37 => 4, 40 => 5, 38 => 6, 39 => 7],
				special: false,
				specialTag: "",
				control_set: null
			};
			case 6: //1K
			mi = {
				keys: 1,
				arrows: ['white'],
				controls: ["6k3"],
				arrowkeys: [40 => 0], //originally no arrow keys for 1k, now you get to press down arrow
				special: false,
				specialTag: "",
				control_set: null
			};
			case 7: //2K
			mi = {
				keys: 2,
				arrows: ['purple', 'red'],
				controls: ["note_left", "note_right"],
				arrowkeys: [37 => 0, 39 => 1],
				special: false,
				specialTag: "",
				control_set: null
			};
			case 8: //3K
			mi = {
				keys: 3,
				arrows: ['purple', 'white', 'red'],
				controls: ["note_left", "9k4", "note_right"],
				arrowkeys: [37 => 0, 38 => 1, 39 => 2], //added down arrow for middle button
				special: false,
				specialTag: "",
				control_set: null
			};
			case 20: //13K
			mi = {
				keys: 13,
				//arrows: ['yellow', 'violet', 'darkred', 'dark', 'purple', 'blue', 'white', 'green', 'red', 'yellow', 'violet', 'darkred', 'dark'],
				arrows: ['purple', 'blue', 'green', 'red', '13a', '13b', 'white', '13c', '13d', 'yellow', 'violet', 'darkred', 'dark'],
				controls: ["9k0", "9k1", "9k2", "9k3", "note_left", "note_down", "9k4", "note_up", "note_right", "9k5", "9k6", "9k7", "9k8"],
				arrowkeys: [37 => 4, 40 => 5, 38 => 7, 39 => 8],
				special: false,
				specialTag: "",
				control_set: null
			};
			case 21: //12K
			mi = {
				keys: 12,
				arrows: ['purple', 'blue', 'green', 'red', '13a', '13b', '13c', '13d', 'yellow', 'violet', 'darkred', 'dark'],
				controls: ["9k0", "9k1", "9k2", "9k3", "note_left", "note_down", "note_up", "note_right", "9k5", "9k6", "9k7", "9k8"],
				arrowkeys: [37 => 4, 40 => 5, 38 => 6, 39 => 7],
				special: false,
				specialTag: "",
				control_set: null
			};
			case 22: //21K
			//idk who reads this
			//there's gonna be no assets from the original 21 keys mod
			//any assets will be custom made
			mi = {
				keys: 21,
				//haha 21 keys mod
				arrows: [
					'yellow', 'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark',
					'white',
					'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark','red'
				],
				/*arrows: [
					'21la', '21lb', '21lc', '21ld', '21le', '21lf', 
					'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark'
					'21ra', '21rb', '21rc', '21rd', '21re', '21rf', 
				],*/
				//this needs controls
				//im gonna try this
				controls: new Array<String>(), //i hate controls.hx fuck that shit
				arrowkeys: [-1 => 0], //no arrow keys fuck u
				special: false,
				specialTag: "",
				control_set: null
			};
			case 23: //19K (combined 4k+6k+9k)
			mi = {
				keys: 19,
				arrows: [
					'13a', '13c', '13d',
					'purple', 'blue', 'green', 'red', 
					'13a', '13b', 'white', '13c', '13d',
					'yellow', 'violet', 'darkred', 'dark',
					'13a', '13b', '13d'
				],
				/*arrows: [
					'21la', '21lb', '21lc',
					'purple', 'blue', 'green', 'red', 
					'13a', '13b', 'white', '13c', '13d',
					'yellow', 'violet', 'darkred', 'dark',
					'21rd', '21re', '21rf'
				],*/
				controls: [
					"6k0", "6k1", "6k2", 
					"9k0", "9k1", "9k2", "9k3",
					"note_left", "note_down", "9k4", "note_up", "note_right",
					"9k5", "9k6", "9k7", "9k8",
					"6k3", "6k4", "6k5"
				],
				arrowkeys: [37 => 7, 40 => 8, 38 => 10, 39 => 11],
				special: false,
				specialTag: "",
				control_set: null
			};
			//also add combined 19k and 21k (but wHYYY you are squeezing this game to death)
			case 24: //50k (this actually not controllable)
			//"Y'know what I dare you to do it"
			//-Mr.Shadow
			mi = {
				keys: 50,
				arrows: [
					'purple', 'blue', 'green', 'red', 'white', 'white', 'yellow', 'violet', 'darkred', 'dark',
					'purple', 'blue', 'green', 'red', 'white', 'white', 'yellow', 'violet', 'darkred', 'dark',
					'purple', 'blue', 'green', 'red', 'white', 'white', 'yellow', 'violet', 'darkred', 'dark',
					'purple', 'blue', 'green', 'red', 'white', 'white', 'yellow', 'violet', 'darkred', 'dark',
					'purple', 'blue', 'green', 'red', 'white', 'white', 'yellow', 'violet', 'darkred', 'dark'
				],
				/*arrows: [
					'21la', '21lb', '21lc', '21ld', '21le', '21lf',
					'purple', 'blue', 'green', 'red',
					'yellow', 'violet', 'darkred', 'dark',
					'13a', '13b', 'white', '13c', '13d',
					'purple', 'green', 'red', '21la', '21lb', '21lc', '21ld', '21le', '21lf', 'yellow', 'blue', 'dark',
					'13a', '13b', 'white', '13c', '13d',
					'purple', 'blue', 'green', 'red',
					'yellow', 'violet', 'darkred', 'dark',
					'21ra', '21rb', '21rc', '21rd', '21re', '21rf'
				],*/
				controls: new Array<String>(), //just use botplay
				//or maybe i can put some midi keyboard support
				arrowkeys: [-1 => 0], //no arrow keys
				special: false,
				specialTag: "",
				control_set: null
			};
			case 25: //Piano
			mi = {
				keys: 25,
				arrows: [
					'piano1k',
					'pianoblack',
					'piano2k',
					'pianoblack',
					'piano3k',
					'piano4k',
					'pianoblack',
					'piano5k',
					'pianoblack',
					'piano6k',
					'pianoblack',
					'piano7k',
					'piano1k',
					'pianoblack',
					'piano2k',
					'pianoblack',
					'piano3k',
					'piano4k',
					'pianoblack',
					'piano5k',
					'pianoblack',
					'piano6k',
					'pianoblack',
					'piano7k',
					'piano8k',
				],
				controls: new Array<String>(), //just use botplay
				//or maybe i can put some midi keyboard support
				arrowkeys: [-1 => 0], //no arrow keys
				special: true,
				specialTag: "piano",
				control_set: null
			};
			case 26: //105
			mi = {
				keys: 105,
				arrows: [
					'yellow', 'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark',
					'white',
					'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark','red',
					'yellow', 'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark',
					'white',
					'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark','red',
					'yellow', 'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark',
					'white',
					'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark','red',
					'yellow', 'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark',
					'white',
					'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark','red',
					'yellow', 'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark',
					'white',
					'purple', 'blue', 'green', 'red', 'white', 'yellow', 'violet', 'darkred', 'dark','red'
				],
				controls: new Array<String>(), //just use botplay
				//or maybe i can put some midi keyboard support
				arrowkeys: [-1 => 0], //no arrow keys
				special: false,
				specialTag: "",
				control_set: null
			};
			case 27: //10K
			mi = {
				keys: 10,
				arrows: ['purple', 'blue', 'green', 'red', '13a', '13d', 'yellow', 'violet', 'darkred', 'dark'],
				controls: ["9k0", "9k1", "9k2", "9k3", "note_left", "note_right", "9k5", "9k6", "9k7", "9k8"],
				arrowkeys: [37 => 5, 40 => 6, 38 => 7, 39 => 8],
				special: false,
				specialTag: "",
				control_set: null
			};
			case 28: //11K
			mi = {
				keys: 11,
				arrows: ['purple', 'blue', 'green', 'red', '13a', 'white', '13d', 'yellow', 'violet', 'darkred', 'dark'],
				controls: ["9k0", "9k1", "9k2", "9k3", "note_left", "9k4", "note_right", "9k5", "9k6", "9k7", "9k8"],
				arrowkeys: [37 => 5, 40 => 6, 38 => 7, 39 => 8],
				special: false,
				specialTag: "",
				control_set: null
			};
		};
		mi.control_set = [new Array<Int>(), new Array<Int>()];
		var cid:String = ManiaConvert[mania];
		if (ClientPrefs.vmanControls[cid] != null) {
			for (i in ClientPrefs.vmanControls[cid]) {
				mi.control_set[0].push(i.key);
				mi.control_set[1].push(i.alt);
			}
		}
		return mi;
	}
	
	public static function GetManiaName(mania:SwagMania):String {
		if (mania.special) {
			return mania.keys+"K "+mania.specialTag;
		}
		return mania.keys+"K";
	}
	
	public static function GetNoteScale(mania:SwagMania):Float {
		/*switch(keys) {
			case 1 | 2 | 3 | 4: //4K
			return 0.7;
			case 6: //6K
			return 0.5;
			case 9: //9K
			return 0.65;
			case 5: //5K
			return 0.58;
			case 7: //7K
			return 0.55;
			case 8: //8K
			case 13: //13K
			return 0.5 / 1.5;
			default: //anything else
			return 2.8 / Math.max(keys, 4);
		}
		return 0;*/
		if (mania.specialTag == "piano") {
			return 0.25;
		}
		if (mania.keys <= 4)
			return 0.7;
		return Math.min(4.5 / mania.keys, Math.pow(mania.keys, -0.6) + 0.25);
	}
	
	public static function GetNoteSpacing(mania:SwagMania):Float {
		if (mania.specialTag == "piano") {
			return 0;
		}
		if (mania.keys <= 4)
			return 160 * 0.7;
		return 560 / (mania.keys + 1);
	}
	
	public static function DoNoteSpecial(spr:StrumNote, num:Int, maniaInfo:SwagMania) {
		if (maniaInfo.special) {
			switch(maniaInfo.specialTag) {
				case "piano": {
					var pos:Array<Int> = [0, 1, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18, 20, 21, 22, 23, 24, 25, 26, 28];
					spr.x += 12.5 * pos[num % maniaInfo.keys];
				}
			}
		}
	}
	
	/*public static function GetControlPress(controls:Array<String>):Array<String>
	{
		return [
			for (v in controls) {
				v += "-press";
			}
		];
	}
	
	public static function GetControlRelease(controls:Array<String>):Array<String>
	{
		return [
			for (v in controls) {
				v += "-release";
			}
		];
	}*/
	
	//i also put my funny helper funcs here

	public static function ArrayRepeat(max:Int, val:Any):Any {
		var dumbArray:Array<Int> = [];
		for (i in 0...max)
		{
			dumbArray.push(val);
		}
		return dumbArray;
	}
	
	public static var JudgeNames:Array<String> = ["Sicks", "Goods", "Bads", "Shits", "Misses"];
}
