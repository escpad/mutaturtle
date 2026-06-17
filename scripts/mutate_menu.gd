extends CanvasLayer

signal mutation_changed(l: float, w: float, wt: float)

@onready var length_slider : HSlider = $Overlay/Panel/VBox/LengthRow/LengthSlider
@onready var width_slider  : HSlider = $Overlay/Panel/VBox/WidthRow/WidthSlider
@onready var weight_slider : HSlider = $Overlay/Panel/VBox/WeightRow/WeightSlider
@onready var length_label  : Label   = $Overlay/Panel/VBox/LengthRow/LengthValue
@onready var width_label   : Label   = $Overlay/Panel/VBox/WidthRow/WidthValue
@onready var weight_label  : Label   = $Overlay/Panel/VBox/WeightRow/WeightValue
@onready var budget_label  : Label   = $Overlay/Panel/VBox/BudgetLabel

var _updating := false

func _ready() -> void:
	length_slider.value = 34.0
	width_slider.value  = 33.0
	weight_slider.value = 33.0
	_update_labels()

	length_slider.value_changed.connect(_on_length_changed)
	width_slider.value_changed.connect(_on_width_changed)
	weight_slider.value_changed.connect(_on_weight_changed)

func _on_length_changed(value: float) -> void:
	if _updating: return
	_compress_others(length_slider, value)

func _on_width_changed(value: float) -> void:
	if _updating: return
	_compress_others(width_slider, value)

func _on_weight_changed(value: float) -> void:
	if _updating: return
	_compress_others(weight_slider, value)

func _compress_others(changed: HSlider, new_val: float) -> void:
	_updating = true

	var others: Array[HSlider] = []
	for s: HSlider in [length_slider, width_slider, weight_slider]:
		if s != changed:
			others.append(s)

	var remaining    := 100.0 - new_val
	var sum_others   := others[0].value + others[1].value

	if sum_others > 0.0:
		others[0].value = remaining * others[0].value / sum_others
		others[1].value = remaining * others[1].value / sum_others
	else:
		others[0].value = remaining / 2.0
		others[1].value = remaining / 2.0

	_update_labels()
	_updating = false

	mutation_changed.emit(length_slider.value, width_slider.value, weight_slider.value)

func _update_labels() -> void:
	length_label.text = str(roundi(length_slider.value))
	width_label.text  = str(roundi(width_slider.value))
	weight_label.text = str(roundi(weight_slider.value))
	var total := roundi(length_slider.value + width_slider.value + weight_slider.value)
	budget_label.text = "Budget: %d / 100" % total
