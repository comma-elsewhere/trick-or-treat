extends Node

var items: Dictionary = {
	"Whitefish" = {
		"name": "Lake Whitefish",
		"icon": "res://assets/visual/icons/fishing/shadow/1.png",
		"value": 2,
		"description": "They're everywhere.",
		"type": "fish"
	},
	"Lamprey" = {
		"name": "Sea Lamprey",
		"icon": "res://assets/visual/icons/loot/shadow/6.png",
		"value": 1,
		"description": "Invasive parasites, but not today's problem.",
		"type": "fish"
	},
	"Trout" = {
		"name": "Lake Trout",
		"icon": "res://assets/visual/icons/fishing/shadow/5.png",
		"value": 3,
		"description": "The most normal thing here.",
		"type": "fish"
	},
	"Sturgeon" = {
		"name": "Lake Sturgeon",
		"icon": "res://assets/visual/icons/fishing/shadow/4.png",
		"value": 5,
		"description": "Not what I'm looking for.",
		"type": "fish"
	},
	"Salmon" = {
		"name": "Coho Salmon",
		"icon": "res://assets/visual/icons/fishing/shadow/6.png",
		"value": 4,
		"description": "I hear they're unrecognizable during spawning season.",
		"type": "fish"
	},
	"Pike" = {
		"name": "Northern Pike",
		"icon": "res://assets/visual/icons/fishing/shadow/20.png",
		"value": 4,
		"description": "Carnivorous...",
		"type": "fish"
	},
	"Walleye" = {
		"name": "Walleye",
		"icon": "res://assets/visual/icons/fishing/shadow/17.png",
		"value": 3,
		"description": "They're supposed to be hard to catch.",
		"type": "fish"
	},
	"Muskie" = {
		"name": "Muskie",
		"icon": "res://assets/visual/icons/fishing/shadow/18.png",
		"value": 2,
		"description": "It takes patience to catch these.",
		"type": "fish"
	},
	"Bass" = {
		"name": "Smallmouth Bass",
		"icon": "res://assets/visual/icons/fishing/shadow/22.png",
		"value": 3,
		"description": "People say they're good eating if they're fresh.",
		"type": "fish"
	},
	"Shoe" = {
		"name": "Child's Shoe",
		"icon": "res://assets/visual/icons/loot/shadow/17.png",
		"value": 3,
		"description": "It looks familiar...",
		"type": "loot"
	},
	"Skull" = {
		"name": "Mossy Skull",
		"icon": "res://assets/visual/icons/loot/shadow/19.png",
		"value": 3,
		"description": "It couldn't be, you have to keep looking.",
		"type": "loot"
	},
	"Dagger" = {
		"name": "Ritual Dagger",
		"icon": "res://assets/visual/icons/loot/shadow/16.png",
		"value": 3,
		"description": "What was this used for?",
		"type": "loot"
	},
	"Ring" = {
		"name": "Familiar Ring",
		"icon": "res://assets/visual/icons/loot/shadow/1.png",
		"value": 3,
		"description": "You've seen this before.",
		"type": "loot"
	},
	"Locket" = {
		"name": "Laura's Locket",
		"icon": "res://assets/visual/icons/loot/shadow/2.png",
		"value": 3,
		"description": "This was your daughter's necklace.",
		"type": "loot"
	},
	"SkullPartOne" = {
		"name": "Partial SKull",
		"icon": "res://assets/visual/icons/bones/without_shadow/1.png",
		"value": 3,
		"description": "There are teeth marks in it.",
		"type": "loot"
	},
	"SkullPartTwo" = {
		"name": "Partial SKull",
		"icon": "res://assets/visual/icons/bones/without_shadow/5.png",
		"value": 3,
		"description": "It's been crushed in.",
		"type": "loot"
	},
	"GoodCharm" = {
		"name": "Five of Diamonds",
		"icon": "res://assets/visual/icons/fishing/shadow/34.png",
		"value": 1,
		"description": "Apparently brings good luck.",
		"type": "charm"
	},
	"BadCharm" = {
		"name": "Bad Luck Charm",
		"icon": "res://assets/visual/icons/fishing/shadow/35.png",
		"value": 1,
		"description": "The shopkeep said this will lead me to dark places.",
		"type": "charm"
	},
	"SoulCharm" = {
		"name": "Dream Catcher",
		"icon": "res://assets/visual/icons/fishing/shadow/36.png",
		"value": 1,
		"description": "This was is supposed to guide wayward souls.",
		"type": "charm"
	},
	"BasicRod" = {
		"name": "Basic Rod",
		"icon": "res://assets/visual/icons/fishing/shadow/37.png",
		"value": 1,
		"description": "It's all I have.",
		"type": "rod"
	},
	"AdvancedRod" = {
		"name": "Advanced Rod",
		"icon": "res://assets/visual/icons/fishing/shadow/38.png",
		"value": 1,
		"description": "I can fish deeper with this.",
		"type": "rod"
	},
	"CursedRod" = {
		"name": "Cursed Rod",
		"icon": "res://assets/visual/icons/fishing/shadow/39.png",
		"value": 1,
		"description": "I don't care about safety anymore.",
		"type": "rod"
	},
	"Bait" = {
		"name": "Bait",
		"icon": "res://assets/visual/icons/fishing/shadow/31.png",
		"value": 1,
		"description": "This will attract more fish.",
		"type": "charm"
	},
	"Chum" = {
		"name": "Chum",
		"icon": "res://assets/visual/icons/fishing/shadow/33.png",
		"value": 1,
		"description": "I'm not sure what this will attract.",
		"type": "charm"
	},
	"HookOne" = {
		"name": "Training Hook",
		"icon": "res://assets/visual/icons/fishing/shadow/43.png",
		"value": 1,
		"description": "The only one we had.",
		"type": "hook"
	},
	"HookTwo" = {
		"name": "Beginner Hook",
		"icon": "res://assets/visual/icons/fishing/shadow/44.png",
		"value": 1,
		"description": "It'll do the job.",
		"type": "hook"
	},
	"HookThree" = {
		"name": "Normal Hook",
		"icon": "res://assets/visual/icons/fishing/shadow/45.png",
		"value": 1,
		"description": "I need to do this.",
		"type": "hook"
	},
	"HookFour" = {
		"name": "Pro Hook",
		"icon": "res://assets/visual/icons/fishing/shadow/46.png",
		"value": 1,
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
