extends Camera2D

export var zoom_margin := Vector2(500, 500)

onready var world = find_parent("World")

var extents := Rect2(0, 0, 0, 0)
var window_size : Vector2
var target_factor := 1.0
var current_factor := 1.0

func _ready() -> void:
	get_tree().get_root().connect("size_changed", self, "resize")
	resize()

func _process(_delta: float) -> void:
	var num_balls := len(world.balls)
	if num_balls == 1:
		global_position = world.balls[0].global_position
		zoom = Vector2.ONE
	elif num_balls > 1:
		# figure out the positions
		extents.position = world.balls[0].global_position
		extents.size = Vector2.ZERO
		for ball in world.balls:
			extents = extents.expand(ball.global_position)
		global_position = (extents.position + extents.end) / 2

		# handle zoom
		var target_zoom := (extents.size + zoom_margin) / window_size
		target_factor = max(max(target_zoom.x, target_zoom.y), 1)
		if target_factor < 1.05 * current_factor and target_factor > 0.95 * current_factor:
			target_factor = current_factor
		current_factor = lerp(current_factor, target_factor, 0.2)
		zoom = current_factor * Vector2.ONE


func resize() -> void:
	window_size = get_tree().root.get_visible_rect().size
