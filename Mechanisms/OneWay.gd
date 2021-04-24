extends StaticBody2D

onready var sprite : Sprite = get_node("Sprite")
onready var timer : Timer = get_node("Timer")
onready var layer = collision_layer

func _on_InputSide_body_entered(body: RigidBody2D) -> void:
	if not body is RigidBody2D:
		return
	if body.is_in_group("balls"):
		collision_layer = 0
		timer.start()

func _on_Timer_timeout() -> void:
	collision_layer = layer
