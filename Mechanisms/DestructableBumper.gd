extends RigidBody2D

signal bumper_destroyed

export var hp := 1
export var force := 750.0
export var points := 1

onready var sfx : AudioStreamPlayer2D = find_node("SFX")
onready var sfx2 : AudioStreamPlayer2D = find_node("SFX2")
onready var world := find_parent("World")

func _on_Bumper_body_entered(body: RigidBody2D) -> void:
	if hp <= 0:
		return
	if not body is RigidBody2D:
		return
	if body.is_in_group("balls"):
		sfx.play()
		body.apply_central_impulse(force * (body.global_position - global_position).normalized())
		hp -= 1
		if hp <= 0:
			die()

func die() -> void:
	world.score += points
	visible = false
	collision_layer = 0
	collision_mask = 0
	sfx2.play()
	emit_signal("bumper_destroyed")

func _on_SFX2_finished() -> void:
	queue_free()
