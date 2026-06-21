extends CharacterBody2D

const SPEED = 200.0
const GRAVITY_BASE = 980.0
const JUMP_BASE = -480.0

var length_val := 34.0
var width_val  := 33.0
var weight_val := 33.0

var body_size := Vector2(60.0, 40.0)
var _gravity  := 980.0
var _jump     := JUMP_BASE

var _tex_normal := preload("res://assets/turtle.png")      as Texture2D
var _tex_long   := preload("res://assets/long-turtle.png") as Texture2D
var _tex_tall   := preload("res://assets/tall-turtle.png") as Texture2D

@onready var _col    : CollisionShape2D = $CollisionShape2D
@onready var _sprite : Sprite2D         = $Sprite2D

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	_update_shape()

func apply_mutation(l: float, w: float, wt: float) -> void:
	length_val = l
	width_val  = w
	weight_val = wt
	_update_shape()

func _update_shape() -> void:
	body_size.x = lerp(20.0, 150.0, length_val / 100.0)
	body_size.y = lerp(20.0,  80.0, width_val  / 100.0)
	_gravity    = GRAVITY_BASE * lerp(0.3, 3.0, weight_val / 100.0)
	_jump       = JUMP_BASE    * lerp(2.0, 0.5, weight_val / 100.0)
	_col.shape.size = body_size
	_update_sprite()

func _update_sprite() -> void:
	var tex: Texture2D
	if length_val > 50.0:
		tex = _tex_long
	elif width_val > 50.0:
		tex = _tex_tall
	else:
		tex = _tex_normal
	_sprite.texture = tex
	_sprite.scale   = body_size / Vector2(tex.get_width(), tex.get_height())

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += _gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = _jump

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
