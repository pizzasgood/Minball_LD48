extends KinematicBody2D

enum { LAUNCH_PAD, IN_FLIGHT, DOCKED }

export var speed := 500.0
export var distance_to_dock := 2320

onready var world := find_parent("World")
onready var plunger := get_node("Plunger")
onready var tween : Tween = get_node("Tween")

var state := LAUNCH_PAD
var ball : RigidBody2D

func _ready() -> void:
	plunger.alive = false

func _physics_process(_delta: float) -> void:
	if state == IN_FLIGHT and ball:
		ball.global_position = global_position

func _on_Sensor_body_entered(body: RigidBody2D) -> void:
	if not body is RigidBody2D:
		return
	if body.is_in_group("balls"):
		ball = body
		call_deferred("launch")

func launch() -> void:
	if state != LAUNCH_PAD:
		return
	# switch ball to kinematic so we can carry it safely
	get_parent().remove_gantry()
	ball.mode = RigidBody2D.MODE_KINEMATIC
	# launch
	state = IN_FLIGHT
	tween.interpolate_property(self, "position", self.position, self.position + distance_to_dock * Vector2.UP, distance_to_dock / speed, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	tween.start()

func dock() -> void:
	state = DOCKED
	# take over plunger duty
	plunger.alive = true
	world.active_plunger = plunger
	# return ball to normal and eject it
	ball.mode = RigidBody2D.MODE_RIGID
	ball.apply_central_impulse(Vector2.UP * 1500)

func _on_Tween_tween_completed(_object: Object, _key: NodePath) -> void:
	dock()
