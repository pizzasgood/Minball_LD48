extends RigidBody2D

export var hp := 15
export var force := 750.0

var flash_duration := 1.0
var flash_color := Color.red

onready var sfx : AudioStreamPlayer2D = get_node("SFX")
onready var sfx2 : AudioStreamPlayer2D = get_node("SFX2")
onready var sprite : AnimatedSprite = get_node("AnimatedSprite")
onready var tween : Tween = get_node("Tween")
onready var world : Node2D = find_parent("World")

func _on_Goopster_body_entered(body: RigidBody2D) -> void:
	if hp <= 0:
		return
	if not body is RigidBody2D:
		return
	if body.is_in_group("balls"):
		body.apply_central_impulse(force * (body.global_position - global_position).normalized())
		hit()

func hit() -> void:
	sfx.play()
	tween.interpolate_property(sprite, "modulate", flash_color, Color.white, flash_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()
	hp -= 1
	if hp <= 0:
		die()

func die() -> void:
	visible = false
	collision_layer = 0
	collision_mask = 0
	sfx2.play() #TODO: find a better dying-monster sound!
	world.boss_died()

func _on_SFX2_finished() -> void:
	queue_free()

