extends Node

const SAVE_PATH := "user://save.cfg"
const LEVEL_COUNT := 7

var levels_unlocked := 1

func _ready() -> void:
	_load()

func complete_level(n: int) -> void:
	levels_unlocked = max(levels_unlocked, n + 1)
	_save()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/stage_select.tscn")

func go_to_level(n: int) -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_%d.tscn" % n)

func go_to_stage_select() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/stage_select.tscn")

func go_to_main_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _save() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("game", "levels_unlocked", levels_unlocked)
	cfg.save(SAVE_PATH)

func _load() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(SAVE_PATH) == OK:
		levels_unlocked = cfg.get_value("game", "levels_unlocked", 1)
