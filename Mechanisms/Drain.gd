extends Area2D

onready var world := find_parent("World")
onready var sfx := get_node_or_null("SFX")
onready var sfx_banish := get_node_or_null("SFX_Banish")
onready var tween : Tween = get_node("Tween")

export var banish_duration = 2

func _on_Drain_body_entered(body: RigidBody2D) -> void:
	if not body is RigidBody2D:
		return
	if body.is_in_group("balls"):
		if sfx:
			sfx.play()
		world.remove_ball(body)

func banish() -> void:
	if sfx_banish:
		sfx_banish.play()
	tween.interpolate_property(self, "position", position, position + 1000 * Vector2.DOWN, banish_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	queue_free()
