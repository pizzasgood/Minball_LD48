extends RigidBody2D

export var hp := 1
export var force := 750.0

onready var sfx : AudioStreamPlayer2D = find_node("SFX")
onready var sfx2 : AudioStreamPlayer2D = find_node("SFX2")

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
	visible = false
	collision_mask = 0
	sfx2.play()

func _on_SFX2_finished() -> void:
	queue_free()
