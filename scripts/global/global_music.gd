extends Node2D

var intro = load("res://assets/audio/music/Project_14 intro.mp3")
var loop = load("res://assets/audio/music/Project_14 loop.mp3")

var intro_time: float = 36.527
var loop_time: float = 73.166

var audio_player: AudioStreamPlayer

func _ready() -> void:
	audio_player = AudioStreamPlayer.new()
	audio_player.bus = "Music"
	add_child(audio_player)
	_play_intro()
	
func _play_intro():
	audio_player.stream = intro
	audio_player.play()
	await get_tree().create_timer(intro_time).timeout
	audio_player.stream = loop
	_play_loop()
	
func _play_loop():
	audio_player.play(0.0)
	await get_tree().create_timer(loop_time).timeout
	audio_player.stop()
	_play_loop()
	
