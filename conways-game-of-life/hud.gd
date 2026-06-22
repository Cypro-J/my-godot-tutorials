extends CanvasLayer

# Notifies `Main` that configuration has been updated
signal configuration_updated

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_configuration_pressed() -> void:
	$ConfigurationMenu.show()


func _on_configuration_menu_configuration_updated() -> void:
	configuration_updated.emit()
