extends Control

func _on_play_pressed() -> void:
	GameManager.go_to_stage_select()

func _on_quit_pressed() -> void:
	get_tree().quit()
