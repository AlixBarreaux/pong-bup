extends Node2D
class_name Level


func _ready() -> void:
	Events.new_game_started.emit()
