extends Node2D

@onready var turtle      : CharacterBody2D = $Turtle
@onready var mutate_menu : CanvasLayer     = $MutateMenuLayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	mutate_menu.visible = false
	mutate_menu.mutation_changed.connect(turtle.apply_mutation)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_E:
			_toggle_menu()
			get_viewport().set_input_as_handled()

func _toggle_menu() -> void:
	var opening := not mutate_menu.visible
	mutate_menu.visible = opening
	get_tree().paused   = opening
