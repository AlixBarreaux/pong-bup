extends ControllerPaddle
class_name ControllerPaddleAI


var ball: Ball = null
var ball_position: Vector2 = Vector2(0.0, 0.0)


func _ready() -> void:
	ball = get_tree().get_first_node_in_group("balls")
	assert(ball != null)


func _physics_process(_delta: float) -> void:
	ball_position = ball.global_position
	#paddle.global_position.x = ball_position.x
	
	paddle.velocity.x = paddle.speed
	paddle.move_and_slide()
