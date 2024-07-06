extends StaticBody2D
class_name Paddle


@export var speed: float = 500.0
@export var team_id: int = 0

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var coll_shape: Shape2D = collision_shape_2d.get_shape()
@onready var coll_shape_size: Vector2 = coll_shape.get_size()


func get_width() -> float:
	return coll_shape_size.x

func get_height() -> float:
	return coll_shape_size.y


func get_half_width() -> float:
	return self.get_width() / 2

func get_half_height() -> float:
	return self.get_height() / 2


var direction: Vector2 = Vector2(0.0, 0.0)
var velocity: Vector2 = Vector2(0.0, 0.0)


func stop_moving_on_arena_boundaries() -> void:
	if self.get_global_position().x < self.get_half_width():
		if self.direction.x == -1:
			self.stop_moving_x()
	elif self.get_global_position().x > ViewportCalculations.get_viewport_width() - self.get_half_width():
		if self.direction.x == 1:
			self.stop_moving_x()


func move_left() -> void:
	self.direction.x = -1

func move_right() -> void:
	self.direction.x = 1


func stop_moving_x() -> void:
	self.direction.x = 0


var gap_length_y: float = ViewportCalculations.get_viewport_height() / 10
var initial_position: Vector2 = Vector2(0.0, 0.0)

func set_global_position_to_initial_position() -> void:
	self.set_global_position(initial_position)


func reset() -> void:
	self.stop_moving_x()
	self.set_global_position_to_initial_position()


func on_new_game_started() -> void:
	self.reset()


func _ready() -> void:
	assert(self.team_id > 0)
	
	Events.new_game_started.connect(on_new_game_started)
	
	if self.team_id == 1:
		self.initial_position = Vector2(ViewportCalculations.get_viewport_center_global_position().x, ViewportCalculations.get_viewport_height() - gap_length_y)
	else:
		self.initial_position = Vector2(ViewportCalculations.get_viewport_center_global_position().x, gap_length_y)


func _physics_process(delta: float) -> void:
	self.stop_moving_on_arena_boundaries()
	self.velocity = self.direction * self.speed * delta
	self.global_position += self.velocity
