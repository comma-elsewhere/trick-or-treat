extends VBoxContainer

@export var jump_button: Button
@export var left_button: Button
@export var right_button: Button
@export var interact_button: Button
@export var fish_button: Button
@export var inventory_button: Button

const ACTIONS = {
	"jump": "jump",
	"left": "left",
	"right": "right",
	"interact": "interact",
	"attack": "attack",
	"inventory": "inventory",
}

var waiting_for_input: String = ""

func _ready() -> void:
	jump_button.button_up.connect(_on_rebind_button_pressed.bind("jump"))
	left_button.button_up.connect(_on_rebind_button_pressed.bind("left"))
	right_button.button_up.connect(_on_rebind_button_pressed.bind("right"))
	interact_button.button_up.connect(_on_rebind_button_pressed.bind("interact"))
	fish_button.button_up.connect(_on_rebind_button_pressed.bind("attack"))
	inventory_button.button_up.connect(_on_rebind_button_pressed.bind("inventory"))

func _input(event: InputEvent) -> void:
	if waiting_for_input == "":
		return
		
	if event is InputEventKey and event.pressed:
		var input_map = waiting_for_input
		var action_name = ACTIONS[input_map]
		
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name, event)
		
		_update_button_label(input_map)
		
		waiting_for_input = ""
		set_process_input(false)

func _get_button(input_name: String) -> Button:
	match input_name:
		"jump": return jump_button
		"left": return left_button
		"right": return right_button
		"interact": return interact_button
		"attack": return fish_button
		"inventory": return inventory_button
		_: return null
		
func _update_button_label(input_name: String):
	var action_name = ACTIONS[input_name]
	var events = InputMap.action_get_events(action_name)
	
	var label_text = "Unassigned"
	
	if events.size() > 0:
		var event = events[0]
		if event is InputEventKey:
			if event.keycode != 0:
				label_text = OS.get_keycode_string(event.keycode)
			elif event.physical_keycode != 0: 
				label_text = OS.get_keycode_string(event.physical_keycode)
	
	var btn = _get_button(input_name)
	btn.text = "%s" % label_text

func _update_labels():
	for map in ACTIONS.keys():
		_update_button_label(map)
		
func _on_rebind_button_pressed(input_map: String):
	waiting_for_input = input_map
	var btn = _get_button(input_map)
	btn.text = ". . ."
	set_process_input(true)
