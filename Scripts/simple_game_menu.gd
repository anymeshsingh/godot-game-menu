class_name SimpleGameMenu
extends Control
## Base class


func _ready():
	GameInputManager.on_input_type_changed.connect(_input_type_change)


# Virtual function
func _input_type_change(_input_type: GameInputManager.InputType) -> void:
	pass
