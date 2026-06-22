extends Node

@export var cell_scene: PackedScene
var grid_size: int

var alive_cells: Array[Node2D] = []
var cells: Array[Array]

func build_grid() -> void:
	var window_size = get_window().size

	print("Building grid of size %s on screen size %s." % [grid_size, window_size])
	var x_cells = window_size.x / grid_size
	var y_cells = window_size.y / grid_size
	print("Grid will be %s by %s cells" % [x_cells, y_cells])
	$Grid.grid_size = grid_size
	$Grid.queue_redraw()

	cells = []
	for y in range(0, y_cells):
		var row_cells: Array[Node2D] = []
		cells.append(row_cells)
		for x in range(0, x_cells):
			var cell = cell_scene.instantiate()
			cell.grid_size = grid_size
			cell.position.x = x * grid_size
			cell.position.y = y * grid_size
			
			# TODO: DEbugging props
			cell.x = x
			cell.y = y
			add_child(cell)
			row_cells.append(cell)
	# Set cell neighbours
	for y in range(0, y_cells):
		for x in range(0, x_cells):
			var neighbours: Array[Node2D] = []
			var cell = cells[y][x]
			if y > 0:
				if x > 0:
					neighbours.append(cells[y-1][x-1])
				neighbours.append(cells[y-1][x])
				if x < x_cells-1:
					neighbours.append(cells[y-1][x+1])
			if x > 0:
				neighbours.append(cells[y][x-1])
			if x < x_cells-1:
				neighbours.append(cells[y][x+1])
			if y < y_cells-1:
				if x > 0:
					neighbours.append(cells[y+1][x-1])
				neighbours.append(cells[y+1][x])
				if x < x_cells-1:
					neighbours.append(cells[y+1][x+1])
			cell.neighbours = neighbours
			# TODO: Not sure if I need this, seems to work without but it is needed for the grid
			# TODO: Grid needs it when adjusting the grid size via settings
			#cell.queue_redraw()

func live(cell: Node2D) -> void:
	alive_cells.append(cell)
	cell.is_alive = true
	cell.queue_redraw()
func die(cell: Node2D) -> void:
	alive_cells.erase(cell)
	cell.is_alive = false
	cell.queue_redraw()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HUD/ConfigurationMenu.apply_settings(true)
	_on_hud_configuration_updated()
	build_grid()

	# Set a blinker alive, for debugging only
	# TODO: Make better initial state
	var window_size = get_window().size
	var x_cells = cells.size()
	var y_cells = cells[0].size()
	if x_cells >= 3 && y_cells >= 3:
		live(cells[0][1])
		live(cells[1][1])
		live(cells[2][1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hud_configuration_updated() -> void:
	grid_size = $HUD/ConfigurationMenu.grid_size
	build_grid()


func _on_update_timer_timeout() -> void:
	var to_check = alive_cells.duplicate()
	for cell in alive_cells:
		for n in cell.neighbours:
			if !to_check.has(n):
				to_check.append(n)

	var to_alive: Array[Node2D] = []
	var to_kill: Array[Node2D] = []
	for cell in to_check:
		var alive_neighbours = cell.neighbours.filter(func(c): return c.is_alive).size()
		if cell.is_alive:
			if alive_neighbours < 2 || alive_neighbours > 3:
				to_kill.append(cell)
		elif alive_neighbours == 3:
			to_alive.append(cell)

	for cell in to_alive:
		live(cell)
	for cell in to_kill:
		die(cell)
