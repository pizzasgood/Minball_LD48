extends Node2D

func _on_DropTargets_targets_complete(targets: Node2D, _body: RigidBody2D) -> void:
	print("COMPLETE")
	targets.raise()
