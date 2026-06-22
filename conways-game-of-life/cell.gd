extends Node2D

var grid_size: int
var neighbours: Array[Node2D]
var is_alive: bool

# TODO: Remove later (or not), useful for debugging
var x: int
var y: int

func _draw():
	if x == 0 && y == 1:
		# THE FUCK!?! This guy has 1 too many neightbours, but rendering is also scuffed
		pass

	if is_alive:
		draw_rect(Rect2(0.0, 0.0, grid_size, grid_size), Color.WHITE)
	else:
		draw_rect(Rect2(0.0, 0.0, grid_size, grid_size), Color.BLACK)
	var center = Vector2(grid_size/2, grid_size/2)
	for n in neighbours:
		if n.position.x < position.x && n.position.y == position.y:
			# Left
			draw_line(Vector2(0, grid_size/2), center, Color.VIOLET)
		elif n.position.x > position.x && n.position.y == position.y:
			# Right
			draw_line(center, Vector2(grid_size, grid_size/2), Color.YELLOW)
		elif n.position.y < position.y:
			if n.position.x < position.x:
				# Upper left
				draw_line(Vector2(0, 0), center, Color.DEEP_PINK)
			elif n.position.x == position.x:
				# Up
				draw_line(Vector2(grid_size/2, 0), center, Color.RED)
			elif n.position.x > position.x:
				# Upper right
				draw_line(Vector2(grid_size, 0), center, Color.ORANGE)
			else:
				assert("Can't map this")
		elif n.position.y > position.y:
			if n.position.x < position.x:
				# Down left
				draw_line(Vector2(0, grid_size), center, Color.INDIGO)
			elif n.position.x == position.x:
				# Down
				draw_line(center, Vector2(grid_size/2, grid_size), Color.BLUE)
			elif n.position.x > position.x:
				# Down right
				draw_line(center, Vector2(grid_size, grid_size), Color.GREEN)
			else:
				assert("Can't map this")
		else:
			assert("Can't map this")
		pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
