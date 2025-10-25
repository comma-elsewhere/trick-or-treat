extends VBoxContainer

@export var option_one: Button
@export var option_two: Button
@export var option_three: Button
@export var option_four: Button
@export var shopkeep_dialogue: Label

@export var other_stuff: Button
@export var ask_questions: Button

var children: Array
var option_buttons: Array

var talk: Dictionary = {
	"option_one" = {
		"question" : "Good morning",
		"answer" : "You shouldn't be here.",
		"hide" : true,
		"unlock" : null
	},
	"option_two" = {
		"question" : "Crazy place, huh?",
		"answer" : "You have no idea...",
		"hide" : true,
		"unlock" : null
	},
	"option_three" = {
		"question" : "I've seen some strange things.",
		"answer" : "Heh heh... This is a strange place, maybe if you ask the right questions, you find some answers.",
		"hide" : true,
		"unlock" : "unlock_questions"
	},
	"option_four" = {
		"question" : "Do you sell anything else?",
		"answer" : "Hm... Perhaps you're ready, but be warned. Some things are worth more than all the money in the world.",
		"hide" : true,
		"unlock" : "unlock_other_stuff"
	},
}

func _ready() -> void:
	option_buttons = [option_one, option_two, option_three, option_four]
	children = get_children(false)
	show_shopkeep(false)
	ask_questions.visible = false
	other_stuff.visible = false
	ready_buttons()
	
	option_one.pressed.connect(_on_dialogue_button_pressed.bind(option_one.text))
	option_two.pressed.connect(_on_dialogue_button_pressed.bind(option_two.text))
	option_three.pressed.connect(_on_dialogue_button_pressed.bind(option_three.text))
	option_four.pressed.connect(_on_dialogue_button_pressed.bind(option_four.text))
	
	
func ready_buttons():
	for key in talk.keys():
		for button in option_buttons:
			if button.get_name() == key:
				button.text = talk[button.get_name()].question
				button.visible = talk[button.get_name()].hide
				

func _on_dialogue_button_pressed(button_text: String):
	for key in talk.keys():
		if button_text == talk[key].question:
			shopkeep_dialogue.text = talk[key].answer
			if talk[key].unlock != null:
				call(talk[key].unlock)
	show_shopkeep(true)

func show_shopkeep(shopkeep_visible: bool):
	children.back().visible = shopkeep_visible
	children.front().visible = !shopkeep_visible

func unlock_questions():
	ask_questions.visible = true

func unlock_other_stuff():
	other_stuff.visible = true

func _on_continue_button_pressed() -> void:
	show_shopkeep(false)
	
