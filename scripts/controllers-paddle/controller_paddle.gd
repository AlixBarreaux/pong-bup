extends Node2D
class_name ControllerPaddle


@export var paddle: Paddle = null


func _ready() -> void:
	if paddle == null:
		if self.get_parent() is Paddle:
			paddle = self.get_parent()
	assert(paddle != null)
