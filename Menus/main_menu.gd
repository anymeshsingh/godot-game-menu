extends SimpleGameMenu


var _exit_dialog: SimpleDialog

@onready var main_menu_container = $MainMenuContainer
@onready var menu_options: MenuOptions = $MainMenuContainer/MenuOptions


func _ready():
	menu_options.on_menu_button_pressed.connect(_on_menu_button_pressed)


func _on_menu_button_pressed(button_text: String):
	match button_text:
		"Continue":
			pass
		"New Game":
			pass
		"Settings":
			pass
		"Exit Game":
			_on_exit_game_button_pressed()


func _on_exit_game_button_pressed():
	main_menu_container.visible = false
	_exit_dialog = SimpleDialog.init("Would you like to exit the game?")
	_exit_dialog.on_confirm_pressed.connect(_on_exit_dialog_confirm_pressed)
	_exit_dialog.on_cancel_pressed.connect(_on_exit_dialog_cancel_pressed)
	add_child(_exit_dialog)


func _on_exit_dialog_confirm_pressed():
	get_tree().quit()


func _on_exit_dialog_cancel_pressed():
	main_menu_container.visible = true
	if GameInputManager.is_input_type_keyboard():
		menu_options.focus_first()
	if _exit_dialog:
		_exit_dialog.queue_free()
