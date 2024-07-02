extends ControllerPaddle
class_name ControllerPaddlePlayer


func _physics_process(_delta: float) -> void:
	paddle.global_position.x = get_global_mouse_position().x
