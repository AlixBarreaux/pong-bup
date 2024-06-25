extends CharacterBody2D
class_name Ball


var last_hit_by_team_id: int = 0

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
# Used by other scenes calculating their own boundaries
@onready var colli_shape_square_extents: float = collision_shape_2d.get_shape().get_size().x

@export var speed: float = 800.0
var direction: Vector2 = Vector2(0.0, 0.0)


var kicker_team_id: int = 0

func launch() -> void:
	if self.kicker_team_id == 1:
		self.direction.y = 1
	else:
		self.direction.y = -1


func stop() -> void:
	self.direction = Vector2(0.0, 0.0)


@export var arena_center: ArenaCenter = null


func on_round_ready() -> void:
	self.show()


func swap_kicker() -> void:
	if self.kicker_team_id == 1:
		self.kicker_team_id = 2
	else:
		self.kicker_team_id = 1


func on_goal_scored(_last_hit_by_team_id: int, _cage_owner_team_id: int, _value: int) -> void:
	self.stop()
	self.hide()
	self.set_global_position(arena_center.get_global_position())
	
	self.swap_kicker()


func on_launch_authorized() -> void:
	self.launch()


func _ready() -> void:
	assert(arena_center != null)
	
	Events.round_ready.connect(on_round_ready)
	Events.ball_launch_authorized.connect(on_launch_authorized)
	Events.goal_scored.connect(on_goal_scored)
	
	randomize()
	self.kicker_team_id = randi_range(1, Global.team_count)	
	self.launch()


func _physics_process(_delta: float) -> void:
	self.velocity = Vector2(0.0, 0.0)
	
	if get_slide_collision_count() >= 1:
		var collision: KinematicCollision2D = get_slide_collision(0)
		
		if collision.get_collider() is Paddle:
			var paddle: Paddle = collision.get_collider()
			direction = (self.global_position - paddle.global_position).normalized()
		else:
			direction = direction.bounce(collision.get_normal())
	
	self.velocity = self.direction * self.speed
	move_and_slide()
