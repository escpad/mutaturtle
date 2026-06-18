extends Node2D

@export var level_num: int = 1

@onready var turtle      := $Turtle
@onready var mutate_menu := $MutateMenuLayer
@onready var goal        := $Goal

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	mutate_menu.visible = false
	mutate_menu.mutation_changed.connect(turtle.apply_mutation)
	goal.body_entered.connect(_on_goal_entered)

func _input(event: InputEvent) -> void:
	if not (event is InputEventKey and event.pressed and not event.echo):
		return
	match event.keycode:
		KEY_E:
			_toggle_menu()
			get_viewport().set_input_as_handled()
		KEY_ESCAPE:
			get_viewport().set_input_as_handled()
			GameManager.go_to_stage_select()

func _toggle_menu() -> void:
	var opening = not mutate_menu.visible
	mutate_menu.visible = opening
	get_tree().paused   = opening

func _on_goal_entered(body: Node2D) -> void:
	if body == turtle:
		GameManager.complete_level(level_num)
