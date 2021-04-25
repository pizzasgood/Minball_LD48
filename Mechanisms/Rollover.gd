extends Area2D

signal target_hit(target, body)

export var state := false

onready var lamp : Node2D = find_node("Lamp")
onready var sfx : AudioStreamPlayer2D = find_node("SFX")

func _ready() -> void:
	update()

func _on_Rollover_body_entered(body: RigidBody2D) -> void:
	if not body is RigidBody2D:
		return
	if body.is_in_group("balls"):
		sfx.play()
		set_to(not state)
		emit_signal("target_hit", self, body)

func update() -> void:
	lamp.light_set(state)

func set_to(new_state: bool) -> void:
	state = new_state
	update()

func blink() -> void:
	lamp.blink()
