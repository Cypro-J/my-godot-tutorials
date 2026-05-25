extends CanvasLayer

const CONFIG_FILE = "user://config.cfg"
const DISPLAY_SECTION = "Display"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_apply_pressed() -> void:
	# Save the configuration settings
	var config = ConfigFile.new()
	config.set_value(DISPLAY_SECTION, "ScreenWidth", $VBoxContainer/GridContainer/ScreenWidth.value)
	config.set_value(DISPLAY_SECTION, "ScreenHeight", $VBoxContainer/GridContainer/ScreenHeight.value)
	config.save(CONFIG_FILE)
	print("Saved new configuration to " + CONFIG_FILE)
	$".".hide()
	apply_settings()


func apply_settings() -> void:
	var config = ConfigFile.new()
	var _err = config.load(CONFIG_FILE)
	# TODO: Check if ignoring the _err is ok. Does it still allow get_value and fallback to the defaults?

	# TODO: Move/remove hardcoded values from here. Not sure if this is a good place to keep them
	var screen_width = config.get_value(DISPLAY_SECTION, "ScreenWidth", 640)
	var screen_height = config.get_value(DISPLAY_SECTION, "ScreenHeight", 480)
	var display_size = Vector2i(screen_width, screen_height)
	# TODO: Value validation, what if I manually enter strings in my config file
	get_window().size = display_size
