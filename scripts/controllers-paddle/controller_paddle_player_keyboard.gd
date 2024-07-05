extends ControllerPaddle
class_name ControllerPaddlePlayer


func _physics_process(_delta: float) -> void:
	var new_direction_x: float = Input.get_axis("move_left", "move_right")
	
	if new_direction_x == -1:
		paddle.move_left()
	elif new_direction_x == 1:
		paddle.move_right()
	else:
		paddle.stop_moving_x()
