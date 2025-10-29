extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

signal started_fishing()
signal finished_fishing(success: bool, item: Resource)

@export var catch_window: float = 1.0
@export var can_fish: bool = false
@onready var fishing_indicator = $fishing_indicator
var is_fishing: bool = false
var is_waiting_for_bite: bool = false

@onready var boat = get_tree().get_first_node_in_group("Boat")

func _ready() -> void:
	add_to_group("player")
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	animation_player.play("fade-in")

func _input(event):
	if event.is_action_pressed("interact") and can_fish and not is_fishing:
		start_fishing()
	if event.is_action_pressed("attack") and is_waiting_for_bite:
		attempt_catch()

func start_fishing():
	is_fishing = true
	velocity = Vector2.ZERO
	
	if fishing_indicator:
		fishing_indicator.show_waiting()
	
	var bite_time = randf_range(2.0, 5.0)
	await get_tree().create_timer(bite_time).timeout

	if is_fishing:
		on_fish_bite()
	
	
	set_physics_process(false)

func on_fish_bite():
	is_waiting_for_bite = true
	
   
	if fishing_indicator:
		fishing_indicator.show_exclamation()
	
	await get_tree().create_timer(catch_window).timeout
	
	if is_waiting_for_bite:
		fail_catch()


func attempt_catch():
	print("XD")
	if not is_waiting_for_bite:
		return
	
	is_waiting_for_bite = false
	
	# Ocultar indicador
	if fishing_indicator:
		fishing_indicator.hide()
	
	# Iniciar minijuego
	started_fishing.emit()
	
func fail_catch():
	is_waiting_for_bite = false
	is_fishing = false
	
	if fishing_indicator:
		fishing_indicator.hide()
	
	print("You lost it!")
	
func end_fishing(success: bool, item: Resource):
	is_fishing = false
	finished_fishing.emit(success, item)
	
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	if !boat.player_in_boat:
		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func death():
	animation_player.play("fadeout")
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fadeout":
		get_tree().call_deferred("reload_current_scene")
