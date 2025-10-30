@tool
extends Node2D
class_name Water

@export var water_size: Vector2 = Vector2(8.0, 16.0)
@export var surface_pos_y: float = 0.5
@export_range(2,512) var segment_count: int = 64

@export var player_splash_multiplier: float = 0.12
@export_range(0.0,1000.0) var water_physics_speed: float = 80.0
@export var water_restorting_force: float = 0.02
@export var wave_energy_loss: float = 0.04
@export var wave_strength: float = 0.25
@export_range(1,64) var wave_spread_updates: int = 8

@export var surface_line_thickness: float = 1.0
@export var surface_color: Color = Color("3ce1da")
@export var water_fill_color = Color("37b0c5")

var segment_data: Array = []
var recently_splashed: bool = false

var surface_line: Line2D
var fill_polygon: Polygon2D

var timer
var make_timer: bool = true

@export_tool_button("Update Water", "Callable") var update_water_button: Callable = _button_update

func _ready() -> void:
	for i in get_children():
		i.queue_free()
		
	_initiate_water()
	
func _process(delta: float) -> void:
	update_physics(delta)
	update_visuals()
	
func _button_update():
	_ready()
	update_visuals()

func _initiate_water() -> void:
	segment_data.clear()
	for i in range(segment_count):
		segment_data.append({
			"height": surface_pos_y,
			"velocity": 0.0,
			"wave to left": 0.0,
			"wave to right": 0.0
		})
		
	var new_line: Line2D = Line2D.new()
	new_line.width = surface_line_thickness
	new_line.default_color = surface_color
	add_child(new_line)
	surface_line = new_line
	
	var new_polygon: Polygon2D = Polygon2D.new()
	new_polygon.color = water_fill_color
	new_polygon.show_behind_parent = true
	surface_line.add_child(new_polygon)
	fill_polygon = new_polygon
	
	var new_area: Area2D = Area2D.new()
	new_area.body_entered.connect(_on_body_entered)
	new_area.body_exited.connect(_on_body_exited)
	add_child(new_area)
	
	var new_collision_shape: CollisionShape2D = CollisionShape2D.new()
	var new_shape: RectangleShape2D = RectangleShape2D.new()
	new_shape.size = water_size
	new_collision_shape.shape = new_shape
	new_collision_shape.position = water_size/2.0 + Vector2(0, surface_pos_y/2.0)
	new_area.add_child(new_collision_shape)
	
	
	timer = Timer.new()
	timer.wait_time = randf_range(5, 10)
	timer.process_callback = Timer.TIMER_PROCESS_PHYSICS
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(start_spooky_wave)
	timer.start()
	
func update_physics(delta: float) -> void:
	for i in range(segment_count):
		var displacement = segment_data[i]["height"] - surface_pos_y
		var acceleration = -water_restorting_force * displacement - segment_data[i]["velocity"] * wave_energy_loss
		
		segment_data[i]["velocity"] += acceleration * delta * water_physics_speed
		segment_data[i]["height"] += segment_data[i]["velocity"] * delta * water_physics_speed
		
	for updates in range(wave_spread_updates):
		for i in range(segment_count):
			if i > 0:
				segment_data[i]["wave to left"] = (segment_data[i]["height"] - segment_data[i-1]["height"]) * wave_strength
				segment_data[i-1]["velocity"] += segment_data[i]["wave to left"] * delta * water_physics_speed
			if i < segment_count - 1:
				segment_data[i]["wave to right"] = (segment_data[i]["height"] - segment_data[i+1]["height"]) * wave_strength
				segment_data[i+1]["velocity"] += segment_data[i]["wave to right"] * delta * water_physics_speed
		
		for i in range(segment_count):
			if i > 0:
				segment_data[i-1]["height"] += segment_data[i]["wave to left"] * delta * water_physics_speed
			if i < segment_count - 1:
				segment_data[i+1]["height"] += segment_data[i]["wave to right"] * delta * water_physics_speed
		
	segment_data[0]["height"] = surface_pos_y
	segment_data[1]["height"] = surface_pos_y
	segment_data[0]["velocity"] = 0.0
	segment_data[1]["velocity"] = 0.0
	
	segment_data[segment_count - 1]["height"] = surface_pos_y
	segment_data[segment_count - 2]["height"] = surface_pos_y
	segment_data[segment_count - 1]["velocity"] = 0.0
	segment_data[segment_count - 2]["velocity"] = 0.0
	
	if !recently_splashed:
		var is_still: bool = true
		for i in surface_line.points:
			if abs(abs(i.y) - abs(surface_pos_y)) > 0.001:
				is_still = false
				break
		set_process(!is_still)
	else:
		recently_splashed = false
	
func update_visuals() -> void:
	var points: Array[Vector2] = []
	var segment_width: float = water_size.x / (segment_count - 1)
	for i in range(segment_count):
		points.append(Vector2(i * segment_width, segment_data[i]["height"]))
		
	var left_static_point: Vector2 = Vector2(points[0].x, surface_pos_y)
	var right_static_point: Vector2 = Vector2(points[points.size()-1].x, surface_pos_y)
	
	var final_points: Array[Vector2] = []
	final_points.append(left_static_point)
	final_points += points
	final_points.append(right_static_point)
	
	surface_line.points = final_points
	
	var bottom_y: float = surface_pos_y + water_size.y
	final_points.append(Vector2(water_size.x, bottom_y))
	final_points.append(Vector2(0, bottom_y))
	fill_polygon.polygon = final_points
	
func splash(splash_pos: Vector2, splash_velocity: float) -> void:
	var local_x_pos: float = to_local(splash_pos).x
	var segment_width: float = water_size.x / (segment_count - 1)
	var index: int = int(clamp(local_x_pos / segment_width, 0, segment_count - 1))
	segment_data[index]["velocity"] = splash_velocity
	recently_splashed = true
	play_splash_sound_varied(splash_pos)
	set_process(true)

func play_splash_sound_varied(splash_pos: Vector2):
	var splash_player = AudioStreamPlayer2D.new()
	add_child(splash_player)
	
	splash_player.pitch_scale = randf_range(0.6, 1.4)
	splash_player.volume_db = randf_range(-3.0, 3.0)
	splash_player.global_position = splash_pos
	
	if has_node("../Audio manager/WaterSplash"):
		var original_sound = get_node("../Audio manager/WaterSplash")
		splash_player.stream = original_sound.stream
	splash_player.finished.connect(splash_player.queue_free)
	splash_player.play(0.6)

	
func start_spooky_wave():
	var segment_width: float = water_size.x / (segment_count - 1)
	var start_x: float = randf_range(0, water_size.x - 30.0)
	var end_x: float = start_x + 25.0
	var range_x = int((end_x - start_x) / segment_width)
	var omega = (end_x - start_x) / PI
	for x in range(range_x):
		var current_x = start_x + x
		var splash_velocity: float = cos(omega * (current_x - start_x)) * 75
		var x_pos: Vector2 = Vector2(current_x, 0.0)
		splash(x_pos, splash_velocity)
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("CanSplash"):
		splash(body.global_position, -body.velocity.y * player_splash_multiplier)
		
func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("CanSplash"):
		splash(body.global_position, body.velocity.y * player_splash_multiplier)
