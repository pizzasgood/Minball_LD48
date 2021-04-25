extends Node2D

export var state := true

onready var light : Light2D = get_node("Light2D")
onready var sprite : AnimatedSprite = get_node("AnimatedSprite")
onready var timer : Timer = get_node("Timer")
var on_frame := 0
var off_frame := 1

func _ready() -> void:
	light_set(state)

func light_on() -> void:
	light_set(true)

func light_off() -> void:
	light_set(false)

func light_toggle() -> bool:
	light_set(not state)
	return state

func light_set(new_state: bool) -> void:
	state = new_state
	light.enabled = state
	sprite.playing = false
	if state:
		sprite.frame = on_frame
	else:
		sprite.frame = off_frame

func blink() -> void:
	sprite.playing = true

func blink_for(seconds: float) -> void:
	blink()
	timer.wait_time = seconds
	timer.start()

func _on_Timer_timeout() -> void:
	light_off()
