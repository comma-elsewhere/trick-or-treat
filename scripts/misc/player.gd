extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -300.0

signal started_fishing()
signal finished_fishing(success: bool, item: Resource)

@export var can_fish: bool = false
var is_fishing: bool = false

@onready var boat = get_tree().get_first_node_in_group("Boat")

func _ready() -> void:
	add_to_group("player")
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _input(event):
	if event.is_action_pressed("interact") and can_fish and not is_fishing:
		start_fishing()
		print("fishing")

func start_fishing():
	is_fishing = true
	started_fishing.emit()
	
	set_physics_process(false)

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
