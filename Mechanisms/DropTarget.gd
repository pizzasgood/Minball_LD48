extends Area2D

signal target_hit(target, body)

export var up := true

onready var sfx : AudioStreamPlayer2D = find_node("SFX")

func _ready() -> void:
	if up:
		raise()
	else:
		drop()

func _on_DropTarget_body_entered(body: RigidBody2D) -> void:
	if not up:
		return
	if not body is RigidBody2D:
		return
	if body.is_in_group("balls"):
		sfx.play()
		drop()
		emit_signal("target_hit", self, body)

func drop() -> void:
	up = false
	visible = false

func raise() -> void:
	up = true
	visible = true
