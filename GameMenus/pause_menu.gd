@tool
class_name PauseMenu
extends GameMenus


@export var pause_menu_title: String = "Pause Menu":
	set(value):
		pause_menu_title = value
		_set_pause_menu_title()

var _exit_dialog: SimpleDialog
var _exit_to_title_screen_dialog: SimpleDialog


@onready var pause_menu_container = $PauseMenuContainer
@onready var pause_menu_title_label = $PauseMenuContainer/GameTitleContainer/PauseMenuTitleLabel
@onready var menu_options = $PauseMenuContainer/MenuOptions


func _ready():
	_set_pause_menu_title()
	menu_options.on_menu_button_pressed.connect(_on_menu_button_pressed)


func _set_pause_menu_title():
	pause_menu_title_label.text = pause_menu_title


func _on_menu_button_pressed(button_text: String):
	match button_text:
		"Resume Game":
			queue_free()
		"Settings":
			pass
		"Exit to Title Screen":
			_on_exit_to_title_screen_button_pressed()
		"Exit Game":
			_on_exit_game_button_pressed()


func _on_exit_to_title_screen_button_pressed():
	pause_menu_container.visible = false
	_exit_to_title_screen_dialog = MenuComponents.init_simple_dialog("", "Would you like to go back to the title screen?", [{"text": "Yes", "input_map": "ui_accept"}, {"text": "No", "input_map": "ui_cancel"}])
	_exit_to_title_screen_dialog.button_focus_sound = preload("res://Audio/select_006.ogg")
	_exit_to_title_screen_dialog.button_press_sound = preload("res://Audio/confirmation_003.ogg")
	_exit_to_title_screen_dialog.on_dialog_button_pressed.connect(_on_exit_to_title_screen_dialog_button_pressed)
	add_child(_exit_to_title_screen_dialog)


func _on_exit_to_title_screen_dialog_button_pressed(button_text: String):
	match button_text:
		"Yes":
			var menu_scene = load("res://Demo/main_menu_scene.tscn")
			get_tree().change_scene_to_packed(menu_scene)
		"No":
			pause_menu_container.visible = true
			if !GameInputManager.is_input_type_keyboard():
				menu_options.focus_first()
			if _exit_to_title_screen_dialog:
				_exit_to_title_screen_dialog.queue_free()


func _on_exit_game_button_pressed():
	pause_menu_container.visible = false
	_exit_dialog = MenuComponents.init_simple_dialog("", "Would you like to exit the game?", [{"text": "Yes", "input_map": "ui_accept"}, {"text": "No", "input_map": "ui_cancel"}])
	_exit_dialog.button_focus_sound = preload("res://Audio/select_006.ogg")
	_exit_dialog.button_press_sound = preload("res://Audio/confirmation_003.ogg")
	_exit_dialog.on_dialog_button_pressed.connect(_on_exit_dialog_button_pressed)
	add_child(_exit_dialog)


func _on_exit_dialog_button_pressed(button_text: String):
	match button_text:
		"Yes":
			get_tree().quit()
		"No":
			pause_menu_container.visible = true
			if !GameInputManager.is_input_type_keyboard():
				menu_options.focus_first()
			if _exit_dialog:
				_exit_dialog.queue_free()
