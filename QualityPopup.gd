extends CenterContainer

onready var hq_button : Button = find_node("HQ")
onready var lq_button : Button = find_node("LQ")

func start_game() -> void:
	get_tree().change_scene("res://Main.tscn")

func _on_HQ_pressed() -> void:
	Globals.low_quality = false
	start_game()

func _on_LQ_pressed() -> void:
	Globals.low_quality = true
	start_game()

func _ready() -> void:
	hq_button.connect("pressed", self, "_on_HQ_pressed")
	lq_button.connect("pressed", self, "_on_LQ_pressed")
	visible = false

func popup() -> void:
	visible = true
	if Globals.low_quality:
		lq_button.grab_focus()
	else:
		hq_button.grab_focus()
