extends ControllerPaddle
class_name ControllerPaddlePlayer


func _physics_process(_delta: float) -> void:
	paddle.direction.x = Input.get_axis("move_left", "move_right")
