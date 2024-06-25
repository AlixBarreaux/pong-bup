extends Node
#class_name Global


enum GameModes {
	Classic,
	WallGame
}

var game_mode: GameModes = GameModes.Classic

var team_count: int = 2

var teams = []

var team_info: Dictionary = {
	"id": 0,
	"score": 0
}


func on_goal_scored(last_hit_by_team_id: int, cage_owner_team_id: int, value: int) -> void:
	increase_score_of_team(last_hit_by_team_id, cage_owner_team_id, value)


func _ready() -> void:
	Events.goal_scored.connect(on_goal_scored)
	
	for count in team_count:
		var new_team_info = team_info.duplicate(true)
		new_team_info.id = count + 1
		teams.append(new_team_info)

# Value: Increased BY
signal score_increased(team_id: int, value: int)
# Value: New updated score
signal score_changed(team_id: int, value: int)

func increase_score_of_team(_last_hit_by_team_id: int, cage_owner_team_id: int, value: int) -> void:
	var team_id_receiving_points: int = 0
	var updated_score: int = 0
	
	for team in teams:
		if team.id != cage_owner_team_id:
			team.score += value
			
			team_id_receiving_points = team.id
			updated_score = team.score
	
	self.score_increased.emit(team_id_receiving_points, value)
	self.score_changed.emit(team_id_receiving_points, updated_score)
