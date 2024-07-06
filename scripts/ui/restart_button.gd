extends Button
class_name RestartButton


func _on_pressed() -> void:
	Events.new_game_started.emit()
	get_tree().set_pause(false)
