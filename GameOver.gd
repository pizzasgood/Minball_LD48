extends CenterContainer

onready var cheat_button : Button = find_node("CheatButton")
onready var quit_button : Button = find_node("QuitButton")

func display() -> void:
	visible = true
	cheat_button.grab_focus()
	get_tree().paused = true

func _on_CheatButton_pressed() -> void:
	var world := find_parent("Main").find_node("World")
	world.extra_balls += 3
	cheat_button.get_node("SFX").play()
	if len(world.balls) == 0:
		world.spawn_ball()
	visible = false
	get_tree().paused = false

func _on_QuitButton_pressed() -> void:
	visible = false
	get_tree().paused = false
	get_tree().change_scene("res://TitleScreen.tscn")

func _ready() -> void:
	visible = false
	cheat_button.connect("pressed", self, "_on_CheatButton_pressed")
	quit_button.connect("pressed", self, "_on_QuitButton_pressed")
