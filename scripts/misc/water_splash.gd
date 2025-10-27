extends AudioStreamPlayer

@onready var water:Water = get_tree().get_first_node_in_group("Water")

func _ready() -> void:
	water.splash_sound.connect(play_audio)
	
func play_audio():
	if !playing:
		play(0.8)
