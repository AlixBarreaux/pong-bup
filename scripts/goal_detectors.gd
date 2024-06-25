extends Node2D
class_name GoalDetectors

## Detects when a goal is scored, by which team, and which team failed to defend it.
##
## It generates its collision shapes automatically on ready.
## It's set so the ball disappears out of the screen before being handled 
## rather than abruptly stopping it right away when it's still on screen to the player's eye.


@export var balls: Node2D = null

@onready var goal_detector_bottom: GoalDetector = $GoalDetectorBottom
@onready var goal_detector_top: GoalDetector = $GoalDetectorTop


func _ready() -> void:
	assert(balls != null)
	
	var ball: Ball = balls.get_child(0)
	
	var viewport_width: float = ProjectSettings.get_setting("display/window/size/viewport_width")
	var viewport_height: float = ProjectSettings.get_setting("display/window/size/viewport_height")
	
	var half_viewport_width: float = viewport_width / 2
	
	var collision_shape_height: float = 200.0
	var half_collision_shape_height: float = collision_shape_height / 2
	
	## Gap adding some distance to ensure the ball doesn't disappear suddenly
	## when touching a GoalDetector (ie when the ball isn't out of the screen yet).
	var gap_length: float = ball.colli_shape_square_extents * 2
	
	var detector_bottom_global_position: Vector2 = Vector2(half_viewport_width, (viewport_height + half_collision_shape_height + gap_length))
	var detector_top_global_position: Vector2 = Vector2(half_viewport_width, (-half_collision_shape_height - gap_length))
	
	goal_detector_bottom.set_global_position(detector_bottom_global_position)
	goal_detector_top.set_global_position(detector_top_global_position)
