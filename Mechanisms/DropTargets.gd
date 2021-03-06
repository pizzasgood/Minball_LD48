extends Node2D

signal targets_complete(targets, body)

export var up := true

onready var targets := [
	get_node("DropTarget"),
	get_node("DropTarget2"),
	get_node("DropTarget3"),
]
onready var lamp := find_node("Lamp*")

func _ready() -> void:
	for i in targets:
		i.connect("target_hit", self, "_on_target_hit")
	if up:
		raise()
	else:
		drop()

func _on_target_hit(_target: Area2D, body: RigidBody2D) -> void:
	var num_up = 0
	for i in targets:
		if i.up:
			num_up += 1
	if num_up == 0:
		emit_signal("targets_complete", self, body)
		if lamp:
			lamp.blink_for(1)

func drop() -> void:
	up = false
	for i in targets:
		i.drop()
	if lamp:
		lamp.light_off()

func raise() -> void:
	up = true
	for i in targets:
		i.raise()
	if lamp:
		lamp.light_on()
