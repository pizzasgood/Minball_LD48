extends RigidBody2D

export var hp := 3
export var force := 750.0

onready var sfx : AudioStreamPlayer2D = find_node("SFX")

func _on_Bumper_body_entered(body: RigidBody2D) -> void:
	if hp <= 0:
		return
	if not body is RigidBody2D:
		return
	if body.is_in_group("balls"):
		sfx.play()
		body.apply_central_impulse(force * (body.position - position).normalized())
		hp -= 1
		if hp <= 0:
			die()

func die() -> void:
	print("poof")
	queue_free()
