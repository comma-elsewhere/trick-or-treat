extends VBoxContainer

@export var option_one: Button
@export var option_two: Button
@export var option_three: Button
@export var option_four: Button
@export var shopkeep_dialogue: Label

var children: Array
var option_buttons: Array

var talk: Dictionary = {
	"option_five" = {
		"question" : "What do you know about the lake's history?",
		"answer" : "Nothing. It's been here as long as time immortal.",
		"hide" : true,
		"unlock" : null
	},
	"option_six" = {
		"question" : "",
		"answer" : "",
		"hide" : false,
		"unlock" : null
	},
	"option_seven" = {
		"question" : "",
		"answer" : "",
		"hide" : false,
		"unlock" : null
	},
	"option_eight" = {
		"question" : "",
		"answer" : "",
		"hide" : false,
		"unlock" : null
	}
}

func _ready() -> void:
	option_buttons = [option_one, option_two, option_three, option_four]
	children = get_children(false)
	show_shopkeep(false)
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
	Global.play_audio(self, "WetClick2", 0.74)
	for key in talk.keys():
		if button_text == talk[key].question:
			shopkeep_dialogue.text = talk[key].answer
			if talk[key].unlock != null:
				call(talk[key].unlock)
	show_shopkeep(true)

func show_shopkeep(shopkeep_visible: bool):
	children.back().visible = shopkeep_visible
	children.front().visible = !shopkeep_visible

func _on_continue_button_pressed() -> void:
	show_shopkeep(false)
	
