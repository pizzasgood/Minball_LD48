extends CenterContainer

onready var quit_button : Button = find_node("QuitButton")

func display() -> void:
	visible = true
	quit_button.grab_focus()
	get_tree().paused = true

func _on_QuitButton_pressed() -> void:
	visible = false
	get_tree().paused = false
	get_tree().change_scene("res://TitleScreen.tscn")

func _ready() -> void:
	visible = false
	quit_button.connect("pressed", self, "_on_QuitButton_pressed")
