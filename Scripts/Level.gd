extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func game_over():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
