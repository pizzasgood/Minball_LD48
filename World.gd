extends Node2D

export var extra_balls := 3 setget extra_balls_set

var balls := []
var score := 0 setget score_set

onready var mine_top := get_node("MineTop")
onready var active_plunger := mine_top.get_node("Plunger")
onready var camera : Camera2D = get_node("Camera2D")
onready var gui : CanvasLayer = get_node("../GUI")
onready var hud : Control = gui.find_node("HUD")
onready var score_label : Label = hud.find_node("Score")
onready var balls_label : Label = hud.find_node("Balls")

func _ready() -> void:
	self.score = 0
	spawn_ball()

func extra_balls_set(val: int):
	extra_balls = val
	var s := "Extra Balls: "
	for _i in range(extra_balls):
		s += "*"
	balls_label.text = s

func score_set(val: int):
	score = val
	score_label.text = "Score: %s" % score

func spawn_ball() -> void:
	self.extra_balls -= 1
	balls.append(active_plunger.spawn_ball())

func remove_ball(ball: RigidBody2D) -> void:
	balls.erase(ball)
	ball.queue_free()
	if extra_balls > 0:
		# don't spawn a ball if we're doing multball
		if len(balls) == 0:
			call_deferred("spawn_ball")
	else:
		print("Game Over")

func boss_died() -> void:
	mine_top.enable_hatch()

func _unhandled_input(event: InputEvent) -> void:
	# some cheat codes for debugging
	if OS.is_debug_build():
		if event.is_action_pressed("ui_select"):
			self.extra_balls += 1
			spawn_ball()
		if event.is_action_pressed("cheat_1"):
			get_node("MineTop")._on_DropTargets_targets_complete(null, null)
		if event.is_action_pressed("cheat_2"):
			get_node("MineMiddle")._on_DropTargets_targets_complete(null, null)
		if event.is_action_pressed("cheat_3"):
			get_node("MineBottom")._on_DropTargets_targets_complete(null, null)
		if event.is_action_pressed("cheat_4"):
			get_node("Arena")._on_DropTargets_targets_complete(null, null)
		if event.is_action_pressed("cheat_5"):
			boss_died()
		if event.is_action_pressed("cheat_8"):
			balls[0].position = Vector2(-150, -700)
		if event.is_action_pressed("cheat_9"):
			balls[0].position = Vector2(-150, 2700)
