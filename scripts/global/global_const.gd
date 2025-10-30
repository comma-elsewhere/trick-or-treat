extends Node

var items: Dictionary = {
	"Whitefish" = {
		"name": "Lake Whitefish",
		"icon": "res://assets/visual/final_icons/Lake Whitefish.png",
		"value": 2,
		"description": "They're everywhere, it's almost unnerving.",
		"type": "fish"
	},
	"Trout" = {
		"name": "Lake Trout",
		"icon": "res://assets/visual/final_icons/Trout.png",
		"value": 3,
		"description": "The most normal thing here.",
		"type": "fish"
	},
	"Sturgeon" = {
		"name": "Lake Sturgeon",
		"icon": "res://assets/visual/final_icons/Sturgeon.png",
		"value": 5,
		"description": "Not what I'm looking for.",
		"type": "fish"
	},
	"Walleye" = {
		"name": "Walleye",
		"icon": "res://assets/visual/final_icons/Walleye.png",
		"value": 3,
		"description": "I hear they're hard to find.",
		"type": "fish"
	},
	"Bass" = {
		"name": "Smallmouth Bass",
		"icon": "res://assets/visual/final_icons/Bass.png",
		"value": 3,
		"description": "People say they're good eating...",
		"type": "fish"
	},
	"Shoe" = {
		"name": "Child's Shoe",
		"icon": "res://assets/visual/final_icons/Child Shoe.png",
		"value": 5,
		"description": "It looks so familiar...",
		"type": "loot"
	},
	"Skull" = {
		"name": "Mossy Skull",
		"icon": "res://assets/visual/final_icons/Skull.png",
		"value": 8,
		"description": "It couldn't be... You have to keep looking.",
		"type": "loot"
	},
	"SquidSkull" = {
		"name": "???",
		"icon": "res://assets/visual/final_icons/Squid Head.png",
		"value": 10,
		"description": "This has to be a Halloween prop.",
		"type": "loot"
	},
	"Locket" = {
		"name": "Laura's Locket",
		"icon": "res://assets/visual/final_icons/Child Locket.png",
		"value": 6,
		"description": "It's definitely hers.",
		"type": "loot"
	},
	"HairClip" = {
		"name": "Hair Clip",
		"icon": "res://assets/visual/final_icons/Child Hair Clip.png",
		"value": 4,
		"description": "This looks like Laura's.",
		"type": "loot"
	},
	"Raincoat" = {
		"name": "Small Raincoat",
		"icon": "res://assets/visual/final_icons/Child Raincoat.png",
		"value": 3,
		"description": "This is what she was wearing last.",
		"type": "loot"
	},
	"Hat" = {
		"name": "Child's Hat",
		"icon": "res://assets/visual/final_icons/Child Hat.png",
		"value": 3,
		"description": "It's hers, you must be getting close.",
		"type": "loot"
	},
	"Charm" = {
		"name": "Five of Diamonds",
		"icon": "res://assets/visual/final_icons/Jack_Ole_Diamond_Hook.png",
		"value": 1,
		"description": "Apparently brings good luck.",
		"type": "charm"
	},
	"BasicRod" = {
		"name": "Basic Rod",
		"icon": "res://assets/visual/final_icons/Beginner_Rod.png",
		"value": 0,
		"description": "It's all I have.",
		"type": "rod"
	},
	"AdvancedRod" = {
		"name": "Advanced Rod",
		"icon": "res://assets/visual/final_icons/Advanced_Rod.png",
		"value": 15,
		"description": "I can fish deeper with this.",
		"type": "rod"
	},
	"CursedRod" = {
		"name": "Cursed Rod",
		"icon": "res://assets/visual/final_icons/Cursed_Rod.png",
		"value": 30,
		"description": "I don't care about safety anymore.",
		"type": "rod"
	},
	"Bait" = {
		"name": "Bait",
		"icon": "res://assets/visual/final_icons/Bait.png",
		"value": 5,
		"description": "This will attract more fish.",
		"type": "charm"
	},
	"Chum" = {
		"name": "Chum",
		"icon": "res://assets/visual/final_icons/Chum.png",
		"value": 10,
		"description": "I'm not sure what this will attract.",
		"type": "charm"
	},
	"HookOne" = {
		"name": "Makeshift Hook",
		"icon": "res://assets/visual/final_icons/Basic_Hook.png",
		"value": 0,
		"description": "The only one we had.",
		"type": "hook"
	},
	"HookTwo" = {
		"name": "Normal Hook",
		"icon": "res://assets/visual/final_icons/Beginner_Hook.png",
		"value": 6,
		"description": "It'll do the job.",
		"type": "hook"
	},
	"HookThree" = {
		"name": "Pro Hook",
		"icon": "res://assets/visual/final_icons/Advanced_Hook.png",
		"value": 12,
		"description": "I am going to find her no matter the cost.",
		"type": "hook"
	},
	"SF1" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/2.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF2" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/3.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF3" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/9.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF4" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/10.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF5" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/11.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF6" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/12.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF7" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/17.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF8" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/18.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF9" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/21.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF10" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/22.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF11" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/23.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF12" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/24.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF13" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/28.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF14" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/29.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF15" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/38.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF16" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/40.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF17" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/45.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"SF18" = {
		"name": "Strange Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/48.png",
		"value": 3,
		"description": "This was once alive.",
		"type": "strange"
	},
	"Laura" = {
		"name": "Familiar Fish",
		"icon": "res://assets/visual/icons/strange fish/shadow/42.png",
		"value": 3,
		"description": "Laura...?",
		"type": "special"
	},
}
