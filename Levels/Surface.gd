extends Node2D

onready var gantry := find_node("Gantry")

func remove_gantry() -> void:
	if is_instance_valid(gantry):
		gantry.queue_free()
