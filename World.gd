extends Node2D

export var extra_balls := 3

var balls = []

onready var active_plunger := get_node("MineTop/Plunger")
onready var camera : Camera2D = get_node("Camera2D")

func _ready() -> void:
	spawn_ball()

func spawn_ball() -> void:
	extra_balls -= 1
	balls.append(active_plunger.spawn_ball())

func remove_ball(ball: RigidBody2D) -> void:
	balls.erase(ball)
	if extra_balls > 0:
		call_deferred("spawn_ball")
	else:
		print("Game Over")

func _unhandled_input(event) -> void:
	if event.is_action_pressed("ui_select"):
		extra_balls += 1
		spawn_ball()
