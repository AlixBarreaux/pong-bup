extends Node2D
class_name ControllerPlayer


@export var paddle: Paddle = null


func _ready() -> void:
	if paddle == null:
		paddle = self.get_parent()
	assert(paddle != null)


func _physics_process(delta: float) -> void:
	paddle.global_position.x = get_global_mouse_position().x
