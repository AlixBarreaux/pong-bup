extends Control
class_name PauseMenuUI


@export var first_element_to_grab_focus: Control = null


func enable() -> void:
	self.set_process_unhandled_key_input(true)


func disable() -> void:
	self.set_process_unhandled_key_input(false)


func on_new_game_started() -> void:
	self.hide()
	self.enable()


func on_game_over() -> void:
	self.hide()
	self.disable()


func _ready() -> void:
	self.hide()
	assert(first_element_to_grab_focus != null)
	
	Events.new_game_started.connect(on_new_game_started)
	Events.game_over.connect(on_game_over)


func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_pause"):
		get_tree().get_root().set_input_as_handled()
		self.set_visible(not self.is_visible())
	
		if self.is_visible():
			get_tree().set_pause(true)
			first_element_to_grab_focus.grab_focus()
		else:
			get_tree().set_pause(false)


func _on_resume_button_pressed() -> void:
	self.set_visible(false)
	get_tree().set_pause(false)
