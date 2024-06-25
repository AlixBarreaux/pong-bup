extends Timer
class_name BallLaunchAuthorizationTimer


func on_round_ready() -> void:
	self.start()


func _ready() -> void:
	Events.round_ready.connect(on_round_ready)


func _on_timeout() -> void:
	print(self.name, ": Ball launched emitted!")
	Events.ball_launch_authorized.emit()
