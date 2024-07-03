extends ControllerPaddle
class_name ControllerPaddleAI


var ball: Ball = null
var ball_position: Vector2 = Vector2(0.0, 0.0)





func _ready() -> void:
	ball = get_tree().get_first_node_in_group("balls")
	assert(ball != null)
	
	ball.collided_with_paddle.connect(on_collided_with_paddle)
	self.set_state(self.initial_state)


func chase_ball() -> void:
	if ball_position.x < paddle.global_position.x - paddle.get_half_width():
		paddle.direction.x = -1.0
		print("Chase ball to the left!")
	elif ball_position.x > paddle.global_position.x + paddle.get_half_width():
		paddle.direction.x = 1.0
		print("Chase ball to the right!")
	else:
		self.stop()


func move_to_arena_center_x() -> void:
	var arena_center_position_x: float = ViewportCalculations.get_half_viewport_width()
	var distance_x_between_paddle_and_arena_center: float = absf(arena_center_position_x - paddle.get_global_position().x)

	if distance_x_between_paddle_and_arena_center < 5.0:
		self.set_state(States.Stopped)
	else:
		if paddle.get_global_position().x < arena_center_position_x:
			paddle.direction.x = 1.0
		else:
			paddle.direction.x = -1.0


func stop() -> void:
	paddle.direction.x = 0.0


func on_collided_with_paddle(sent_paddle: Paddle) -> void:
	if sent_paddle == self.paddle:
		self.set_state(States.MovingToArenaCenter)
	else:
		self.set_state(States.Wait)


enum States {
	MovingToArenaCenter,
	Stopped,
	Wait,
	ChaseBall
}

var initial_state: States = States.MovingToArenaCenter

var state: States = States.MovingToArenaCenter

func set_state(new_state: States) -> void:
	self.state = new_state
	prevent_loop_through_same_state = false


@onready var reaction_timer: Timer = $ReactionTimer

var min_reaction_time: float = 0.2
var max_reaction_time: float = 0.4

var prevent_loop_through_same_state: bool = false

func _physics_process(_delta: float) -> void:
	ball_position = ball.global_position
	
	match state:
		States.MovingToArenaCenter:
			move_to_arena_center_x()
			print("Move to center!")
		States.Stopped:
			if prevent_loop_through_same_state:
				print("Locked state!")
				return
			self.stop()
			prevent_loop_through_same_state = true
			print("Stop!")
		States.Wait:
			if prevent_loop_through_same_state:
				print("Locked state!")
				return
			reaction_timer.set_wait_time(randf_range(min_reaction_time, max_reaction_time))
			reaction_timer.start()
			prevent_loop_through_same_state = true
			print("Reaction timer started!")
		States.ChaseBall:
			self.chase_ball()
			print("Chase ball!")
		_:
			printerr("(!) ERROR: In " + self.get_name() + ": Unrecognized state!")


func _on_reaction_timer_timeout() -> void:
	self.set_state(States.ChaseBall)
	print("Timeout!")
