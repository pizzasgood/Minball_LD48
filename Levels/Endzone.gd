extends Node2D

onready var world := find_parent("World")

func _on_Trophy_bumper_destroyed() -> void:
	world.victory()
