# fishing_manager.gd
extends Node

@export var fishing_minigame_scene: PackedScene  
@export var available_fish: Array[FishType] = []
# @export var default_rod: RodType  ← Ya no necesitas esto

var current_minigame: CanvasLayer
var player: CharacterBody2D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if player:
		player.started_fishing.connect(_on_player_started_fishing)

func _on_player_started_fishing():
	start_fishing_minigame()

func start_fishing_minigame():
	var random_fish = available_fish.pick_random()
	var current_rod = Global.get_current_rod()  
	
	if not current_rod:
		push_error("No rod available!")
		return
	
	current_minigame = fishing_minigame_scene.instantiate()
	current_minigame.fish = random_fish
	current_minigame.rod = current_rod
	current_minigame.fishing_finished.connect(_on_fishing_finished)
	
	add_child(current_minigame)

func _on_fishing_finished(success: bool, _fish: FishType, _value: int):
	if not current_minigame:
		return
	
	current_minigame.queue_free()
	current_minigame = null
	
	if player:
		player.end_fishing(success)

func add_item_to_inventory(fish: FishType, value: int):
	print("¡Pescaste: ", fish.fish_name, "! Valor: ", value)
