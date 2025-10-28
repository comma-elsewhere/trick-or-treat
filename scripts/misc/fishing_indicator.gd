extends Node2D

@onready var dots_sprite = $dots
@onready var exclamation_sprite = $exclamation


func _ready():
	hide_indicator()

func show_waiting():
	show()
	dots_sprite.show()
	exclamation_sprite.hide()
	

func show_exclamation():
	show()
	dots_sprite.hide()
	exclamation_sprite.show()
	


func hide_indicator():
	super.hide()
