@tool
class_name MainMenu
extends GameMenus


@export var game_title: String = "The Game Title":
	set(value):
		game_title = value
		_set_game_title()

var _exit_dialog: SimpleDialog

@onready var main_menu_container = $MainMenuContainer
@onready var game_title_label: Label = $MainMenuContainer/GameTitleContainer/GameTitle
@onready var menu_options: MenuOptions = $MainMenuContainer/MenuOptions


func _ready():
	_set_game_title()
	menu_options.on_menu_button_pressed.connect(_on_menu_button_pressed)


func _set_game_title():
	game_title_label.text = game_title


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
	_exit_dialog = MenuComponents.init_simple_dialog("", "Would you like to exit the game?", [{"text": "Yes", "input_map": "ui_accept"}, {"text": "No"}])
	_exit_dialog.button_focus_sound = preload("res://Audio/select_006.ogg")
	_exit_dialog.button_press_sound = preload("res://Audio/confirmation_003.ogg")
	_exit_dialog.on_dialog_button_pressed.connect(_on_exit_dialog_button_pressed)
	add_child(_exit_dialog)


func _on_exit_dialog_button_pressed(button_text: String):
	match button_text:
		"Yes":
			get_tree().quit()
		"No":
			main_menu_container.visible = true
			if !GameInputManager.is_input_type_keyboard():
				menu_options.focus_first()
			if _exit_dialog:
				_exit_dialog.queue_free()
