extends Node2D
class_name ControllerPaddle


@export var paddle: Paddle = null


func _ready() -> void:
	if paddle == null:
		paddle = self.get_parent()
	assert(paddle != null)


#enum CardinalDirectionsFour {
	#Left,
	#Right,
	#Up,
	#Down
#}
#
#func move() -> void:
	#match CardinalDirectionsFour:
		#
