extends CharacterBody2D

signal started_fishing()

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
var disable_self: bool = false
var fishing_cancelled: bool = false  # ← Nueva variable

func _ready() -> void:
	add_to_group("player")
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	fishing_state = State.CANNOT_FISH
	animation_player.play("fade-in")

# Versión final recomendada
func _input(event):
	# Cancelar pesca con movimiento
	if fishing_state == State.WAITING or fishing_state == State.FISH_AVAILABLE:
		if event.is_action_pressed("left") or event.is_action_pressed("right") or \
		   event.is_action_pressed("jump"):
			_cancel_fishing()
			return
	
	# Input de pesca
	if event.is_action_pressed("interact") or event.is_action_pressed("attack"):
		# Si está esperando (3 puntos), cancelar
		if fishing_state == State.WAITING:
			_cancel_fishing()
			return
		
		# Si puede pescar, iniciar
		if fishing_state == State.CAN_FISH:
			if _can_start_fishing():
				_waiting_for_fish()
			else:
				print("Stop moving to fish!")
		
		# Si el pez picó (!), capturar
		elif fishing_state == State.FISH_AVAILABLE:
			Global.play_audio(self, "FishingRodReel", 0.81)
			_start_fish_minigame()

func _can_start_fishing() -> bool:
	# No debe estar presionando teclas de movimiento
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") or \
	   Input.is_action_pressed("jump"):
		return false
	
	# El bote debe estar quieto
	if boat:
		return abs(boat.velocity.x) < 5.0 and abs(boat.velocity.y) < 5.0
	
	return true

func _process(_delta: float) -> void:
	if can_fish and fishing_state == State.CANNOT_FISH:
		fishing_state = State.CAN_FISH
	if !can_fish:
		fishing_state = State.CANNOT_FISH
		fishing_indicator.hide()
		if fishing_state == State.WAITING:
			_cancel_fishing()

func _physics_process(_delta: float) -> void:
	global_position.y = boat.global_position.y - 30
	global_position.x = boat.global_position.x
	move_and_slide()

func _waiting_for_fish() -> void:
	fishing_state = State.WAITING
	fishing_cancelled = false  # Reset flag
	
	if fishing_indicator:
		fishing_indicator.show_waiting()
	
	if !Global.lake_stock.is_empty():
		# Espera para que pique
		var bite_time = randf_range(2.0, 5.0)
		await get_tree().create_timer(bite_time).timeout
		
		# Verificar si fue cancelado durante la espera
		if fishing_cancelled or fishing_state != State.WAITING:
			return
		
		# Pez disponible
		fishing_state = State.FISH_AVAILABLE
		if fishing_indicator:
			fishing_indicator.show_exclamation()
		
		# Ventana de captura
		await get_tree().create_timer(catch_window).timeout
		
		# Verificar si fue cancelado
		if fishing_cancelled:
			return
		
		# Si no atrapó a tiempo, reintentar
		if fishing_state != State.FISHING:
			if fishing_indicator:
				fishing_indicator.hide()
			_waiting_for_fish()

func _cancel_fishing():
	fishing_cancelled = true
	fishing_state = State.CAN_FISH
	
	if fishing_indicator:
		fishing_indicator.hide()
	
	print("Fishing cancelled!")

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

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fadeout":
		get_tree().call_deferred("reload_current_scene")
