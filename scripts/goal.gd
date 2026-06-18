extends Area2D

func _draw() -> void:
	# Pole
	draw_line(Vector2(0, 0), Vector2(0, -60), Color(0.8, 0.8, 0.8), 3)
	# Flag
	draw_colored_polygon(
		PackedVector2Array([Vector2(0, -60), Vector2(28, -48), Vector2(0, -36)]),
		Color(0.2, 0.9, 0.3)
	)
	# Base
	draw_circle(Vector2(0, 0), 5, Color(0.8, 0.8, 0.8))
