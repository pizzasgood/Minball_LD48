extends MarginContainer

onready var resume_button : Button = find_node("ResumeButton")

func _on_ResumeButton_pressed():
	visible = false

func _ready():
	visible = false
	resume_button.connect("pressed", self, "_on_ResumeButton_pressed")

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		if visible:
			_on_ResumeButton_pressed()
			get_tree().set_input_as_handled()
