extends RigidBody2D

export var force := 750.0

onready var sfx : AudioStreamPlayer2D = find_node("SFX")

func _on_Bumper_body_entered(body: RigidBody2D) -> void:
	if not body is RigidBody2D:
		return
	if body.is_in_group("balls"):
		sfx.play()
		body.apply_central_impulse(force * (body.global_position - global_position).normalized())
