extends StaticBody2D
class_name ArenaBoundaries


@onready var collision_shape_2d_left: CollisionShape2D = $CollisionShape2DLeft
@onready var collision_shape_2d_right: CollisionShape2D = $CollisionShape2DRight


func _ready() -> void:
	var viewport_width: float = ViewportCalculations.get_viewport_width()
	var viewport_height: float = ViewportCalculations.get_viewport_height()
	
	var half_viewport_height: float = ViewportCalculations.get_half_viewport_height()
	
	var collision_shape_width: float = 200.0
	var half_collision_shape_width: float = collision_shape_width / 2
	
	
	var colli_shape_left_global_position: Vector2 = Vector2(-half_collision_shape_width, half_viewport_height)
	collision_shape_2d_left.set_global_position(colli_shape_left_global_position)
	
	var colli_shape_right_global_position: Vector2 = Vector2((viewport_width + half_collision_shape_width), half_viewport_height)
	collision_shape_2d_right.set_global_position(colli_shape_right_global_position)
	
	
	for collision_shape in self.get_children() as Array[CollisionShape2D]:
		collision_shape.get_shape().set_size(Vector2(collision_shape_width, viewport_height))
