extends Area2D

@export var shop: Control

@onready var player = get_tree().get_first_node_in_group("Player")

var player_in_area: bool = false

func _ready() -> void:
	shop.visible = false
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and player_in_area:
		shop.visible = !shop.visible
		player.disable_self = !player.disable_self
		if shop.visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
		
func _on_body_entered(body: Node2D):
	if body == player:
		player_in_area = true
	
func _on_body_exited(body: Node2D):
	if body == player:
		player_in_area = false
