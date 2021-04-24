extends Node2D

export var extra_balls := 3

var balls = []
onready var active_plunger := get_node("MineTop/Plunger")

func _ready() -> void:
	spawn_ball()

func spawn_ball() -> void:
	balls.append(active_plunger.spawn_ball())
