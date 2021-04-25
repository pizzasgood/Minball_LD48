extends CenterContainer

onready var resume_button : Button = find_node("ResumeButton")
onready var cheat_button : Button = find_node("CheatButton")
onready var quit_button : Button = find_node("QuitButton")

func _on_ResumeButton_pressed() -> void:
	visible = false
	get_tree().paused = false

func _on_CheatButton_pressed() -> void:
		var world := find_parent("Main").find_node("World")
		world.extra_balls += 1
		cheat_button.get_node("SFX").play()
		if len(world.balls) == 0:
			world.spawn_ball()

func _on_QuitButton_pressed() -> void:
	visible = false
	get_tree().paused = false
	get_tree().change_scene("res://TitleScreen.tscn")

func _ready() -> void:
	visible = false
	resume_button.connect("pressed", self, "_on_ResumeButton_pressed")
	quit_button.connect("pressed", self, "_on_QuitButton_pressed")

func _unhandled_input(event) -> void:
	if event.is_action_pressed("menu"):
		if visible:
			_on_ResumeButton_pressed()
		else:
			visible = true
			resume_button.grab_focus()
			get_tree().paused = true
		get_tree().set_input_as_handled()

