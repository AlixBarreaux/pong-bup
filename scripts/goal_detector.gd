extends Area2D
class_name GoalDetector


# ID of the team guarding it
@export var team_id: int = 0


func _ready() -> void:
	assert(team_id > 0)


func _on_body_entered(body: Ball) -> void:
	Events.goal_scored.emit(body.last_hit_by_team_id, self.team_id, 1)
