extends RigidBody2D

export var force := 500.0
export var bounce_angle := -25.0

onready var bounce_zone := find_node("BounceZone")
onready var sfx : AudioStreamPlayer2D = find_node("SFX")

var direction : Vector2

func _ready() -> void:
	direction = Vector2.RIGHT.rotated(deg2rad(bounce_angle))

func _on_Kicker_body_entered(body: RigidBody2D) -> void:
	if not body is RigidBody2D:
		return
	if body.is_in_group("balls") and bounce_zone.overlaps_body(body):
		sfx.play()
		body.apply_central_impulse(force * direction)
