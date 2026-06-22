extends CanvasLayer

const CONFIG_FILE = "user://config.cfg"
const DISPLAY_SECTION = "Display"

# Notifies `HUD` that configuration has been updated
signal configuration_updated
var grid_size = 15

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Set the fields initial values
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_apply_pressed() -> void:
	# Save the configuration settings
	var config = ConfigFile.new()
	config.set_value(DISPLAY_SECTION, "ScreenWidth", $VBoxContainer/DisplaySettingsGridContainer/ScreenWidth.value)
	config.set_value(DISPLAY_SECTION, "ScreenHeight", $VBoxContainer/DisplaySettingsGridContainer/ScreenHeight.value)
	config.save(CONFIG_FILE)
	print("Saved new configuration to " + CONFIG_FILE)
	grid_size = $VBoxContainer/GameSettingsGridContainer/GridSize.value
	$".".hide()
	apply_settings()
	configuration_updated.emit()


func apply_settings(initial_load: bool = false) -> void:
	var config = ConfigFile.new()
	var _err = config.load(CONFIG_FILE)
	# TODO: Check if ignoring the _err is ok. Does it still allow get_value and fallback to the defaults?

	# TODO: Move/remove hardcoded values from here. Not sure if this is a good place to keep them
	var screen_width = config.get_value(DISPLAY_SECTION, "ScreenWidth", 640)
	var screen_height = config.get_value(DISPLAY_SECTION, "ScreenHeight", 480)
	var display_size = Vector2i(screen_width, screen_height)
	# TODO: Value validation, what if I manually enter strings in my config file
	get_window().size = display_size
	
	if (initial_load):
		# Set the correct values for the menu
		$VBoxContainer/DisplaySettingsGridContainer/ScreenWidth.value = screen_width
		$VBoxContainer/DisplaySettingsGridContainer/ScreenHeight.value = screen_height
		$VBoxContainer/GameSettingsGridContainer/GridSize.value = grid_size
