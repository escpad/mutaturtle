extends Control

@onready var buttons: Array[Button] = []

func _ready() -> void:
	for i in range(1, GameManager.LEVEL_COUNT + 1):
		var btn: Button = get_node("VBox/Level%d" % i)
		buttons.append(btn)
		btn.disabled = (i > GameManager.levels_unlocked)
		var n := i
		btn.pressed.connect(func(): GameManager.go_to_level(n))

func _on_back_pressed() -> void:
	GameManager.go_to_main_menu()
