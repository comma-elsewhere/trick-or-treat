extends CharacterBody2D

@export var pos_y: float = -34.0

@onready var water: Water = get_tree().get_first_node_in_group("Water")

const SPEED: float = 150.0

var player_in_boat: bool = false
var dist_to_water: float
var segment_length: float

func _ready() -> void:
	var_setup()
	
func _physics_process(delta: float) -> void:
	dist_to_water = global_position.distance_to(water.global_position)
	var segment_index = int(dist_to_water / segment_length)
	global_position.y = water.segment_data[segment_index].height - 30.0
	
	var dy = water.segment_data[segment_index+1].height - water.segment_data[segment_index - 1].height
	var angle = atan2(dy,segment_length*2)
	rotation = lerp_angle(rotation, angle, 0.1)
	
	if player_in_boat:
		var dir:= Input.get_axis("left","right")
		if dir:
			velocity.x = dir * SPEED
		else:
			velocity.x = lerp(velocity.x, 0.0, 0.2*delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.5)
		
	move_and_slide()
	
func var_setup():
	segment_length = water.water_size.x / (water.segment_count - 1)
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.velocity.x = 0.0
		player_in_boat = true
		if body.has_method("enable_fishing"):
			body.enable_fishing()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_boat = false
