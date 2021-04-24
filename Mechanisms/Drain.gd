extends Area2D

onready var world := find_parent("World")
onready var sfx := get_node_or_null("SFX")

func _on_Drain_body_entered(body: RigidBody2D) -> void:
	if not body is RigidBody2D:
		return
	if body.is_in_group("balls"):
		if sfx:
			sfx.play()
		world.remove_ball(body)
