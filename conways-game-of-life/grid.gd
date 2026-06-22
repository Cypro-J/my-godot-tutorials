extends Node2D

var grid_size: int

func _draw():
	# TODO: Draw the grid, make it lazy loading. No need to do if not used/shown
	var window_size = get_window().size
	for i in range(grid_size, window_size.x, grid_size):
		draw_line(Vector2(i, 0.0), Vector2(i, window_size.y), Color.DARK_GRAY, 1.0)
	for i in range(grid_size, window_size.y, grid_size):
		draw_line(Vector2(0.0, i), Vector2(window_size.x, i), Color.DARK_GRAY, 1.0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
