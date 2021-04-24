extends Node2D

export var alive := true
export var depth := 50.0
export var draw_speed := 50.0
export var launch_speed := 1500.0

var armed := false
var plunging := false
var current_launch_speed := 0.0

onready var surface : KinematicBody2D = find_node("Surface")
onready var detection_zone : Area2D = find_node("DetectionZone")
onready var sfx : AudioStreamPlayer2D = find_node("SFX")
onready var plunger_min := surface.position.y
onready var plunger_max := surface.position.y + depth

onready var ball_resource := load("res://Ball.tscn")

func _process(_delta: float) -> void:
	if alive and armed:
		if Input.is_action_just_released("flippers_left") or Input.is_action_just_released("flippers_right"):
			sfx.play()
		plunging = Input.is_action_pressed("flippers_left") or Input.is_action_pressed("flippers_right")
	else:
		plunging = false

func _physics_process(delta: float) -> void:
	armed = len(detection_zone.get_overlapping_bodies()) > 0
	if plunging:
		surface.position.y = clamp(surface.position.y + draw_speed * delta, plunger_min, plunger_max)
		current_launch_speed = launch_speed * (surface.position.y - plunger_min) / depth
	elif armed:
		surface.move_and_collide(current_launch_speed * delta * Vector2.UP)
		surface.position.y = clamp(surface.position.y, plunger_min, plunger_max)

func spawn_ball() -> RigidBody2D:
	var ball = ball_resource.instance()
	add_child(ball)
	return ball
