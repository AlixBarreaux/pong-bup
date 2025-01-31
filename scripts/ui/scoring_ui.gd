extends HBoxContainer
class_name ScoringUI


var score_labels: Array[Label] = []


func _ready() -> void:
	var id_counter: int = 1
	
	for label in self.get_children():
		label.team_id = id_counter
		id_counter += 1
		score_labels.insert(score_labels.size(), label)
	
	
	match Global.game_mode:
		Global.GameModes.Classic:
			for node in self.get_children():
				node.show()
		Global.GameModes.WallGame:
			var counter: int = 0
			
			for node in self.get_children():
				if counter == 0:
					counter += 1
					continue
				node.hide()
		_:
			printerr("(!) Error: The value doesn't match any from the enum!")
