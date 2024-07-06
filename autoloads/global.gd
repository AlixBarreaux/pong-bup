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


# Value: Increased BY
signal score_increased(team_id: int, value: int)
# Value: New updated score
signal score_changed(team_id: int, value: int)


func reset_all_team_scores() -> void:
	for team in teams:
		self.set_score_of_team(team.id, 0)


func set_score_of_team(id: int, new_score: int) -> void:
	self.score_changed.emit(id, new_score)


func increase_score_of_team(_last_hit_by_team_id: int, cage_owner_team_id: int, value: int = 1) -> void:
	for team in teams:
		if team.id != cage_owner_team_id:
			self.set_score_of_team(team.id, value)
			self.score_increased.emit(team.id, value)


func on_new_game_started() -> void:
	self.reset_all_team_scores()


func on_goal_scored(last_hit_by_team_id: int, cage_owner_team_id: int, value: int) -> void:
	increase_score_of_team(last_hit_by_team_id, cage_owner_team_id, value)


func _ready() -> void:
	Events.new_game_started.connect(on_new_game_started)
	Events.goal_scored.connect(on_goal_scored)
	
	for count in team_count:
		var new_team_info = team_info.duplicate(true)
		new_team_info.id = count + 1
		teams.append(new_team_info)
