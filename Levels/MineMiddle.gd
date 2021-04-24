extends Node2D

onready var drain := find_node("Drain")

func _on_DropTargets_targets_complete(_targets: Node2D, _body: RigidBody2D) -> void:
	drain.queue_free() #TODO: animate this dropping away
