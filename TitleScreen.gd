extends Node

onready var start_button : Button = find_node("StartButton")
onready var about_button : Button = find_node("AboutButton")
onready var exit_button : Button = find_node("ExitButton")
onready var start_window : Control = find_node("StartWindow")
onready var quality_popup : Control = find_node("QualityPopup")

onready var about_window = find_node("AboutWindow")

func _on_StartButton_pressed() -> void:
	start_window.visible = false
	quality_popup.popup()

func _on_AboutButton_pressed() -> void:
	about_window.visible = true

func _on_ExitButton_pressed() -> void:
	get_tree().quit()

func _ready() -> void:
	start_button.connect("pressed", self, "_on_StartButton_pressed")
	about_button.connect("pressed", self, "_on_AboutButton_pressed")
	exit_button.connect("pressed", self, "_on_ExitButton_pressed")
	start_button.grab_focus()

	if OS.get_name() == "HTML5":
		exit_button.queue_free()
