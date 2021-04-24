extends Node2D

export var extra_balls := 3

var balls = []
onready var active_plunger := get_node("MineTop/Plunger")

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
