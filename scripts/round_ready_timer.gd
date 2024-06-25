extends Timer
class_name RoundReadyTimer


func on_goal_scored(_last_hit_by_team_id: int, _cage_owner_team_id: int, _value: int) -> void:
	self.start()


func _ready() -> void:
	Events.goal_scored.connect(on_goal_scored)


func _on_timeout() -> void:
	print(self.name, ": Round ready!")
	Events.round_ready.emit()
