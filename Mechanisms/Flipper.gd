extends Node2D

export var left_flipper := true
export var alive := true
export var flip_range := 60.0
export var flip_speed := 800

var flipping := false
var current_speed := 0.0
var min_angle : float
var max_angle : float

onready var flipper : KinematicBody2D = find_node("Flipper")
onready var sfx : AudioStreamPlayer2D = find_node("SFX")

func _ready() -> void:
	if left_flipper:
		flip_speed *= -1
		min_angle = -flip_range
		max_angle = 0
	else:
		min_angle = 0
		max_angle = flip_range

func _process(_delta: float) -> void:
	if alive:
		if (left_flipper and Input.is_action_just_pressed("flippers_left")) or (not left_flipper and Input.is_action_just_pressed("flippers_right")):
			sfx.play()
		flipping = (left_flipper and Input.is_action_pressed("flippers_left")) or (not left_flipper and Input.is_action_pressed("flippers_right"))
	else:
		flipping = false

	if flipping:
		current_speed = flip_speed
	else:
		current_speed = -flip_speed


func _physics_process(delta: float) -> void:
	flipper.rotation_degrees = clamp(current_speed * delta + flipper.rotation_degrees, min_angle, max_angle)
