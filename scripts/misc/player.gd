extends CharacterBody2D

signal started_fishing()
#signal finished_fishing(success: bool, item: Resource)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fishing_indicator: Node2D = $fishing_indicator
@onready var boat = get_tree().get_first_node_in_group("Boat")

@export var catch_window: float = 1.0

enum State {
	CANNOT_FISH, 
	CAN_FISH, 
	WAITING, 
	FISH_AVAILABLE, 
	FISHING
	}
	
var fishing_state

var can_fish: bool = false
#var is_fishing: bool = false
#var is_waiting_for_bite: bool = false

var disable_self: bool = false

func _ready() -> void:
	add_to_group("player")
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	fishing_state = State.CANNOT_FISH
	animation_player.play("fade-in")
	

func _input(event):
	if event.is_action_pressed("interact") or event.is_action_pressed("attack"):
		if fishing_state == State.CAN_FISH:
			_waiting_for_fish()
		if fishing_state == State.FISH_AVAILABLE:
			Global.play_audio(self, "FishingRodReel", 0.81)
			_start_fish_minigame()
#	if event.is_action_pressed("interact") and can_fish and not is_fishing:
#		start_fishing()
#	if event.is_action_pressed("attack") and is_waiting_for_bite:
#		attempt_catch()

func _process(_delta: float) -> void:
	if can_fish and fishing_state == State.CANNOT_FISH:
		fishing_state = State.CAN_FISH
	if !can_fish:
		fishing_state = State.CANNOT_FISH
		fishing_indicator.hide()

func _physics_process(_delta: float) -> void:
	global_position.y = boat.global_position.y -30
	global_position.x = boat.global_position.x

	move_and_slide()
	
func _waiting_for_fish() -> void:
	fishing_state = State.WAITING
	if fishing_indicator:
		fishing_indicator.show_waiting()
	
	if !Global.lake_stock.is_empty():
		var bite_time = randf_range(2.0, 5.0)
		await get_tree().create_timer(bite_time).timeout
		
		fishing_state = State.FISH_AVAILABLE
		if fishing_indicator:
			fishing_indicator.show_exclamation()
			
		await get_tree().create_timer(catch_window).timeout
		
		if !fishing_state == State.FISHING:
			if fishing_indicator:
				fishing_indicator.hide()
			_waiting_for_fish()

func _start_fish_minigame() -> void:
	fishing_state = State.FISHING
	started_fishing.emit()
	
	if fishing_indicator:
		fishing_indicator.hide()

func end_fishing(success: bool):
	fishing_state = State.CAN_FISH
	if success:
		if !Global.lake_stock.is_empty():
			var random_int = randi_range(0, Global.lake_stock.size() - 1)
			var caught_fish = Global.lake_stock.pop_at(random_int)
			Global.inventory_stock.append(caught_fish) 

func death():
	animation_player.play("fadeout")
	


#func start_fishing():
#	is_fishing = true
#	velocity = Vector2.ZERO
#	
#	if fishing_indicator:
#		fishing_indicator.show_waiting()
#	
#	var bite_time = randf_range(2.0, 5.0)
#	await get_tree().create_timer(bite_time).timeout
#
#	if is_fishing:
#		on_fish_bite()
#	
#	
#	set_physics_process(false)
#
#func on_fish_bite():
#	is_waiting_for_bite = true
#	
#  
#	if fishing_indicator:
#		fishing_indicator.show_exclamation()
#	
#	await get_tree().create_timer(catch_window).timeout
#	
#	if is_waiting_for_bite:
#		fail_catch()
#
#
#func attempt_catch():
#	print("XD")
#	if not is_waiting_for_bite:
#		return
#	
#	is_waiting_for_bite = false
#	
#	# Ocultar indicador
#	if fishing_indicator:
#		fishing_indicator.hide()
#	
#	# Iniciar minijuego
#	started_fishing.emit()
#	
#func fail_catch():
#	is_waiting_for_bite = false
#	is_fishing = false
#	
#	if fishing_indicator:
#		fishing_indicator.hide()
#	
#	print("You lost it!")
	
#func end_fishing(success: bool, item: Resource):
#	is_fishing = false
#	finished_fishing.emit(success, item)
#	
#	set_physics_process(true)
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fadeout":
		get_tree().call_deferred("reload_current_scene")
