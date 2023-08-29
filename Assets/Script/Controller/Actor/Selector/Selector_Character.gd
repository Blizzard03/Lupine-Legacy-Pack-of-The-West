extends Node2D

var choose_character := preload("res://Assets/Scence/Character/Selector/Selector_Player.tscn")

func _ready() -> void:
	var Character := choose_character.instance()
	get_tree().current_scene.add_child(Character)
