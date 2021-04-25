extends Node2D

var boss_res = preload("res://Mechanisms/Goopster.tscn")
var boss : Node2D
onready var loop_path : Path2D = get_node("BossPath")
onready var entry_path : Path2D = get_node("BossEntryPath")
onready var spawn_point : PathFollow2D = entry_path.get_node("BossSpawn")
onready var boss_tween : Tween = spawn_point.get_node("BossTween")
onready var drain := find_node("Drain")
var entry_duration = 2.0
var loop_duration = 8.0
var boss_in_the_loop := false

func spawn() -> void:
	boss = boss_res.instance()
	spawn_point.add_child(boss)
	boss_tween.interpolate_property(spawn_point, "unit_offset", 0.0, 1.0, entry_duration, Tween.TRANS_LINEAR)
	boss_tween.start()

func _on_DropTargets_targets_complete(_targets, _body) -> void:
	call_deferred("spawn")

func _on_BossTween_tween_completed(_object: Object, _key: NodePath) -> void:
	if not boss_in_the_loop:
		boss_in_the_loop = true
		entry_path.remove_child(spawn_point)
		loop_path.add_child(spawn_point)
		boss_tween.repeat = true
		spawn_point.loop = true
		spawn_point.unit_offset = 0.0
	boss_tween.interpolate_property(spawn_point, "unit_offset", 0.0, 1.0, loop_duration, Tween.TRANS_LINEAR)
	boss_tween.start()

func remove_drain() -> void:
	if is_instance_valid(drain):
		drain.banish()
