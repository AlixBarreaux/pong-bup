extends CharacterBody2D
class_name Paddle


@export var speed: float = 200.0


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
