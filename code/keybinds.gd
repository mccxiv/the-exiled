extends Node

onready var camera: Camera = $"../Camera"

func _input(_event: InputEvent):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
