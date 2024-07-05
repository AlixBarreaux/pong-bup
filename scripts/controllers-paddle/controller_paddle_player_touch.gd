extends ControllerPaddle
class_name ControllerPaddlePlayerTouch


var event_position: Vector2 = Vector2(0.0, 0.0)
var is_click_pressed: bool = false


func move_x() -> void:
	if event_position.x < ViewportCalculations.get_half_viewport_width():
		paddle.move_left()
	else:
		paddle.move_right()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		event_position = event.get_position()
		if event.is_pressed():
			is_click_pressed = true
		else:
			is_click_pressed = false
	
	elif event is InputEventMouseButton:
		event_position = event.get_position()
		if event.button_index == 1:
			if event.is_pressed():
				is_click_pressed = true
			else:
				is_click_pressed = false
				
	get_tree().get_root().set_input_as_handled()

func _physics_process(_delta: float) -> void:
	if is_click_pressed:
		move_x()
	else:
		paddle.stop_moving_x()
