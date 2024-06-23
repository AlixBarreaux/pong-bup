extends CharacterBody2D
class_name Ball


var speed: float = 800.0
var direction: Vector2 = Vector2(0.0, 0.0)


func _ready():
	randomize()
	var initial_direction_x: float = randi() % 2
	
	if initial_direction_x == 0:
		initial_direction_x = -1
	self.direction.x = initial_direction_x


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
