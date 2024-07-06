extends Object
class_name ViewportCalculations


static func get_viewport_width() -> float:
	return ProjectSettings.get_setting("display/window/size/viewport_width")


static func get_viewport_height() -> float:
	return ProjectSettings.get_setting("display/window/size/viewport_height")


static func get_half_viewport_width() -> float:
	return get_viewport_width() / 2


static func get_half_viewport_height() -> float:
	return get_viewport_height() / 2


static func get_viewport_center_global_position() -> Vector2:
	var x: float = ViewportCalculations.get_half_viewport_width()
	var y: float = ViewportCalculations.get_half_viewport_height()
	return Vector2(x, y)
