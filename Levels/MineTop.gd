extends Node2D

onready var drain := find_node("Drain")
onready var hatch_droptargets := find_node("HatchControl")

func _on_DropTargets_targets_complete(_targets: Node2D, _body: RigidBody2D) -> void:
	if is_instance_valid(drain):
		drain.banish()

func enable_hatch() -> void:
	hatch_droptargets.raise()
