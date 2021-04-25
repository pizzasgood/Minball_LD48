extends Node2D

onready var world := find_parent("World")
onready var door_control := get_node("LaserDoorControl")
onready var laser_lamp := get_node("LaserLamp")
onready var tween : Tween = get_node("Tween")
onready var arena := find_parent("World").get_node("Arena")
onready var laser_beam := get_node("LaserBeam")
onready var battery_meter := get_node("Battery/Green")
onready var laser_indicator := get_node("Laser/IndicatorOn")

export var distance_to_depths := 7550
export var speed := 2000.0

var solar_ready := false
var power_ready := false
var ball : RigidBody2D
var ball_collision := []

func _ready() -> void:
	laser_beam.visible = false
	battery_meter.visible = false
	laser_indicator.visible = false

func _process(_delta: float) -> void:
	if laser_beam.visible:
		laser_beam.color.a = 0.8 + 0.2 * sin(OS.get_ticks_msec()/4.0)

func _on_DeathRaySensor_body_entered(body: RigidBody2D) -> void:
	ball = body
	call_deferred("fire_laser")

func _on_PowerControl_targets_complete(_targets, _body) -> void:
	power_ready = true
	laser_indicator.visible = true
	update_door()

func _on_SolarControl_targets_complete(_targets, _body) -> void:
	solar_ready = true
	battery_meter.visible = true
	update_door()

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	call_deferred("stop_laser")

func fire_laser() -> void:
	laser_beam.visible = true
	arena.remove_drain()
	# switch ball to kinematic so we can carry it safely
	ball_collision = [ball.collision_layer, ball.collision_mask]
	ball.collision_layer = 0
	ball.collision_mask = 0
	ball.mode = RigidBody2D.MODE_KINEMATIC
	tween.interpolate_property(ball, "position", ball.position, ball.position + distance_to_depths * Vector2.DOWN, distance_to_depths / speed, Tween.TRANS_LINEAR)
	tween.start()

func stop_laser() -> void:
	laser_beam.visible = false
	# restore plunger duty
	world.active_plunger = world.original_plunger
	# return ball to normal
	ball.mode = RigidBody2D.MODE_RIGID
	ball.collision_layer = ball_collision[0]
	ball.collision_mask = ball_collision[1]

func update_door() -> void:
	if power_ready and solar_ready:
		door_control.raise()
		laser_lamp.light_on()
