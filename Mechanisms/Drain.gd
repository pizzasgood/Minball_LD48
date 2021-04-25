extends Area2D

onready var world := find_parent("World")
onready var sfx := get_node_or_null("SFX")
onready var sfx_banish := get_node_or_null("SFX_Banish")
onready var tween : Tween = get_node("Tween")

export var banish_duration = 2
export var flood_height := 3100
export var flood_speed := 100.0

var banishing = false

func _on_Drain_body_entered(body: RigidBody2D) -> void:
	if not body is RigidBody2D:
		return
	if body.is_in_group("balls"):
		if sfx:
			sfx.play()
		world.remove_ball(body)

func banish() -> void:
	banishing = true
	if sfx_banish:
		sfx_banish.play()
	tween.interpolate_property(self, "position", position, position + 1000 * Vector2.DOWN, banish_duration, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()

func flood() -> void:
	if sfx_banish:
		sfx_banish.play()
	tween.interpolate_property(self, "position", position, position + flood_height * Vector2.UP, flood_height / flood_speed, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	if banishing:
		queue_free()
