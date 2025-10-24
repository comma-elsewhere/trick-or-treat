extends CharacterBody2D

@export var pos_y: float = -34.0

const SPEED: float = 150.0

var player_in_boat: bool = false

func _ready() -> void:
	GSig.rock_the_boat.connect(boat_rocking)
	
func _physics_process(_delta: float) -> void:
	global_position.y = pos_y
	
	if player_in_boat:
		var dir:= Input.get_axis("left","right")
		if dir:
			velocity.x = dir * SPEED
		else:
			velocity.x = lerp(velocity.x, 0.0, 0.2)
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.5)
		
	move_and_slide()
	
func boat_rocking(_splash_pos: Vector2, _splash_velocity: float) -> void:
	pass
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_boat = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_boat = false
