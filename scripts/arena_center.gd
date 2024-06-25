extends Marker2D
class_name ArenaCenter


func _ready() -> void:
	var viewport_width: float = ProjectSettings.get_setting("display/window/size/viewport_width")
	var viewport_height: float = ProjectSettings.get_setting("display/window/size/viewport_height")
	
	self.set_global_position(Vector2((viewport_width / 2), (viewport_height / 2)))
