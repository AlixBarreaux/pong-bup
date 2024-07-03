extends StaticBody2D
class_name Paddle


@export var speed: float = 500.0
var direction: Vector2 = Vector2(0.0, 0.0)


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


var velocity: Vector2 = Vector2(0.0, 0.0)

#@onready var initial_position: Vector2 = self.get_global_position()

func _physics_process(delta: float) -> void:
	#self.set_velocity(Vector2(0.0, 0.0))
	self.velocity = self.direction * self.speed * delta
	self.global_position += self.velocity
	
	#self.set_velocity(self.direction * self.speed)
	#self.set_velocity(Vector2((self.direction.x * self.speed), 0.0))
	
	#self.move_and_slide()
	#self.set_global_position(Vector2(get_global_position().x, initial_position.y))
