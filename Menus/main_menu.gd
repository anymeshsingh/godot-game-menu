extends Control

@onready var menu_container = $MenuContainer
@onready var menu_list_container = $MenuContainer/MenuListContainer

var select_hint: SelectAndBackHint
var exit_dialog: SimpleDialog

func _ready():
	handle_ui_for_controller(GameInputManager.input_type)
	GameInputManager.on_input_type_changed.connect(handle_ui_for_controller)


func handle_ui_for_controller(input_type: GameInputManager.InputType):
	if input_type == GameInputManager.InputType.MNK:
		remove_all_focus()
		hide_select_hint()
	else:
		focus_first()
		show_select_hint()

func focus_first():
	var btns = menu_list_container.get_children()
	if btns.size():
		if btns[0] is Button:
			btns[0].grab_focus()

func remove_all_focus():
	var btns = menu_list_container.get_children()
	for btn in btns:
		if btn is Button:
			btn.release_focus()

func show_select_hint():
	select_hint = SelectAndBackHint.init(true, false)
	add_child(select_hint)

func hide_select_hint():
	if select_hint:
		select_hint.queue_free()

func _on_continue_button_pressed():
	pass # Replace with function body.


func _on_new_game_button_pressed():
	pass # Replace with function body.


func _on_settings_buton_pressed():
	pass # Replace with function body.


func _on_exit_game_button_pressed():
	menu_container.visible = false
	exit_dialog = SimpleDialog.init("Would you like to exit the game?")
	exit_dialog.on_confirm_pressed.connect(_on_exit_dialog_confirm_pressed)
	exit_dialog.on_cancel_pressed.connect(_on_exit_dialog_cancel_pressed)
	add_child(exit_dialog)


##################################
## SimpleDialog Signal Handlers ##
##################################

func _on_exit_dialog_confirm_pressed():
	get_tree().quit()


func _on_exit_dialog_cancel_pressed():
	menu_container.visible = true
	focus_first()
	if exit_dialog:
		exit_dialog.queue_free()
