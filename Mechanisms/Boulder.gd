extends StaticBody2D

onready var sfx : AudioStreamPlayer2D = get_node("SFX")

func _ready() -> void:
	get_parent().connect("targets_complete", self, "_on_targets_complete")

func _on_targets_complete(_targets: Node2D, _body: RigidBody2D):
	queue_free()
