extends ControllerPaddle
class_name ControllerPaddleAI


var ball: Ball = null
var ball_position: Vector2 = Vector2(0.0, 0.0)


@onready var reaction_timer: Timer = $ReactionTimer
@export var min_reaction_time: float = 0.2
@export var max_reaction_time: float = 0.4


enum States {
	MovingToArenaCenter,
	Stopped,
	Wait,
	ChaseBall
}

var initial_state: States = self.States.MovingToArenaCenter
var state: States = self.initial_state

func set_state(new_state: States) -> void:
	self.state = new_state
	self.prevent_loop_through_same_state = false


func chase_ball() -> void:
	if ball_position.x < paddle.get_global_position().x - paddle.get_half_width():
		paddle.move_left()
	elif ball_position.x > paddle.get_global_position().x + paddle.get_half_width():
		paddle.move_right()
	else:
		self.stop()


func move_to_arena_center_x() -> void:
	var arena_center_position_x: float = ViewportCalculations.get_half_viewport_width()
	var distance_x_between_paddle_and_arena_center: float = absf(arena_center_position_x - paddle.get_global_position().x)

	if distance_x_between_paddle_and_arena_center < 5.0:
		self.set_state(States.Stopped)
	else:
		if paddle.get_global_position().x < arena_center_position_x:
			paddle.move_right()
		else:
			paddle.move_left()


func stop() -> void:
	paddle.stop_moving_x()


func on_collided_with_paddle(sent_paddle: Paddle) -> void:
	if sent_paddle == self.paddle:
		self.set_state(States.MovingToArenaCenter)
	else:
		self.set_state(States.Wait)


# Prevents certain functions to fire every frame when switching to another state
var prevent_loop_through_same_state: bool = false


func on_goal_scored(_last_hit_by_team_id: int, _cage_owner_team_id: int, _value: int) -> void:
	self.set_state(States.MovingToArenaCenter)


func _ready() -> void:
	ball = get_tree().get_first_node_in_group("balls") as Ball
	assert(ball != null)
	
	Events.goal_scored.connect(on_goal_scored)
	
	ball.collided_with_paddle.connect(on_collided_with_paddle)
	self.set_state(self.initial_state)


func _physics_process(_delta: float) -> void:
	ball_position = ball.get_global_position()
	
	match state:
		States.MovingToArenaCenter:
			move_to_arena_center_x()
		States.Stopped:
			if prevent_loop_through_same_state:
				return
			self.stop()
			prevent_loop_through_same_state = true
		States.Wait:
			if prevent_loop_through_same_state:
				return
			reaction_timer.set_wait_time(randf_range(min_reaction_time, max_reaction_time))
			reaction_timer.start()
			prevent_loop_through_same_state = true
		States.ChaseBall:
			self.chase_ball()
		_:
			printerr("(!) ERROR: In " + self.get_name() + ": Unrecognized state!")


func _on_reaction_timer_timeout() -> void:
	self.set_state(States.ChaseBall)
