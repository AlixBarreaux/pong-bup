extends Marker2D
class_name ArenaCenter


func _ready() -> void:
	var viewport_width: float = ViewportCalculations.get_viewport_width()
	var viewport_height: float = ViewportCalculations.get_viewport_height()
	
	var half_viewport_width: float = ViewportCalculations.get_half_viewport_width()
	var half_viewport_height: float = ViewportCalculations.get_half_viewport_height()
	
	self.set_global_position(Vector2(half_viewport_width, half_viewport_height))
