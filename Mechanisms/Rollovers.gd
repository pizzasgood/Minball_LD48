extends Node2D

signal targets_complete(targets, body)

onready var world := find_parent("World")
onready var targets := [
	get_node("Rollover"),
	get_node("Rollover2"),
	get_node("Rollover3"),
]

func _ready() -> void:
	for i in targets:
		i.connect("target_hit", self, "_on_target_hit")
	set_targets(false)

func _on_target_hit(_target: Area2D, body: RigidBody2D) -> void:
	var num_up = 0
	for i in targets:
		if i.state:
			num_up += 1
	if num_up == len(targets):
		emit_signal("targets_complete", self, body)
		# TODO: flash in celebration
		set_targets(false)
		print("YAY!  New ball!")
		world.extra_balls += 1

func _unhandled_input(event: InputEvent) -> void:
	# TODO: my GUI is gobbling my mouse events!
	if event.is_action_pressed("flippers_left"):
		cycle_left()
	if event.is_action_pressed("flippers_right"):
		cycle_right()

func set_targets(new_state: bool) -> void:
	for i in targets:
		i.set_to(new_state)

func cycle_left() -> void:
	var tmp = targets[0].state
	for i in range(len(targets)):
		targets[i].set_to(targets[(i + 1) % len(targets)].state)
	targets[-1].set_to(tmp)

func cycle_right() -> void:
	var tmp = targets[-1].state
	for i in range(len(targets)-1, -1, -1):
		targets[i].set_to(targets[(i - 1) % len(targets)].state)
	targets[0].set_to(tmp)
