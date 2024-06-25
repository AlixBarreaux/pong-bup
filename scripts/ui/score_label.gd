extends Label
class_name ScoreLabel


var team_id: int = 0


func on_score_changed(team_id_receiving_points: int, value: int) -> void:
	if self.team_id == team_id_receiving_points:
		self.set_text(str(value))


func _ready() -> void:
	Global.score_changed.connect(on_score_changed)
	
	#for team in Global.teams:
		#print(team.id, " - ", team_id)
		#if team.id == self.team_id:
			#self.set_text(team.score)
	#print("0 score set!")
