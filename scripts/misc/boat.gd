extends CharacterBody2D

@onready var water: Water = get_tree().get_first_node_in_group("Water")
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED: float = 150.0

enum LastInput {LEFT, RIGHT}

var player_in_boat: bool = false
var dist_to_water: float
var segment_length: float
var facing_direction

func _ready() -> void:
	var_setup()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		facing_direction = LastInput.LEFT
	elif event.is_action_pressed("right"):
		facing_direction = LastInput.RIGHT
	
func _physics_process(_delta: float) -> void:
	dist_to_water = global_position.distance_to(water.global_position)
	var segment_index = int(dist_to_water / segment_length)
	if segment_index < water.segment_count:
		global_position.y = water.segment_data[segment_index].height -48.0
	
		var dy = water.segment_data[segment_index+1].height - water.segment_data[segment_index - 1].height
		var angle = atan2(dy,segment_length*2)
		rotation = lerp_angle(rotation, angle, 0.1)
	
	if !player.disable_self:
		var dir:= Input.get_axis("left","right")
		if dir:
			velocity.x = dir * SPEED
		else:
			velocity.x = lerp(velocity.x, 0.0, 0.1)
	else:
		velocity.x = 0.0
		
	if facing_direction == LastInput.LEFT:
		sprite_2d.flip_h = true
	else:
		sprite_2d.flip_h = false
		
	move_and_slide()
	
func var_setup():
	segment_length = water.water_size.x / (water.segment_count - 1)
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.velocity.x = 0.0
		player_in_boat = true
		if body.has_method("enable_fishing"):
			body.enable_fishing(true)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_boat = false
		if body.has_method("enable_fishing"):
			body.enable_fishing(false)
