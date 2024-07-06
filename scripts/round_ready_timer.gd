extends Timer
class_name RoundReadyTimer


func on_goal_scored(_last_hit_by_team_id: int, _cage_owner_team_id: int, _value: int) -> void:
	self.start()


func on_new_game_started() -> void:
	self.start()


func _ready() -> void:
	Events.new_game_started.connect(on_new_game_started)
	Events.goal_scored.connect(on_goal_scored)


func _on_timeout() -> void:
	Events.round_ready.emit()
