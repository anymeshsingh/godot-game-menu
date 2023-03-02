@tool
class_name MenuOptions
extends SimpleGameMenu
## Customisable menu options for game menues.


signal on_menu_button_pressed(button_text: String)

@export_category("MenuOptions")
@export_subgroup("Buttons")
@export var menu_direction: MenuDirection = MenuDirection.VERTICAL:
	set(value):
		menu_direction = value
		_setup_buttons()
@export var text_alignment: HorizontalAlignment = HORIZONTAL_ALIGNMENT_CENTER:
	set(value):
		text_alignment = value
		_setup_buttons()
@export var icon_alignment: HorizontalAlignment = HORIZONTAL_ALIGNMENT_LEFT:
	set(value):
		icon_alignment = value
		_setup_buttons()
@export var buttons: Array[Dictionary] = [{"text": "Continue", "disabled": false }, {"text": "New Game"}, {"text": "Settings"}, {"text": "Exit Game"}]:
	set(value):
		buttons = value
		_setup_buttons()
@export var button_separation: int = 0:
	set(value):
		button_separation = value
		_setup_buttons()

@export_subgroup("Layout Config")
@export var anchor_preset: ControlAnchorPreset = ControlAnchorPreset.PRESET_CENTER_BOTTOM:
	set(value):
		anchor_preset = value
		_setup_theme()
@export var margin_top: int = 100:
	set(value):
		margin_top = value
		_setup_theme()
@export var margin_bottom: int = 100:
	set(value):
		margin_bottom = value
		_setup_theme()
@export var margin_left: int = 100:
	set(value):
		margin_left = value
		_setup_theme()
@export var margin_right: int = 100:
	set(value):
		margin_right = value
		_setup_theme()

@export_subgroup("Audio")
@export var focus_sound: AudioStream
@export var press_sound: AudioStream

@onready var margin_container = $MarginContainer
@onready var audio_stream_player = $AudioStreamPlayer


func _ready():
	super._ready()
	_setup_buttons()
	_setup_theme()

# Override vitual function from [SimpleGameMenu]
func _input_type_change(_input_type: GameInputManager.InputType):
	if _input_type == GameInputManager.InputType.MNK:
		_remove_all_focus()
	else:
		focus_first()


## Controller: Focus on the 1st button
func focus_first():
	var btns := _get_buttons()
	if btns.size():
		btns[0].grab_focus()


func _setup_buttons():
	if !margin_container:
		return
	
	_clear_margin_container()
	
	var container: BoxContainer
	if menu_direction:
		container = HBoxContainer.new()
	else:
		container = VBoxContainer.new()
	
	container.add_theme_constant_override("separation", button_separation)
	
	margin_container.add_child(container)
	
	for button in buttons:
		if button["text"]:
			var btn := Button.new()
			btn.text = button["text"]
			btn.alignment = text_alignment
			
			if button.has("icon") && button["icon"] is Texture2D:
				btn.icon = button["icon"]
				btn.icon_alignment = icon_alignment
			
			if button.has("disabled"):
				btn.disabled = button["disabled"]
			if focus_sound:
				btn.focus_entered.connect(_on_button_focused.bind("focus_entered"))
				btn.mouse_entered.connect(_on_button_focused.bind("mouse_entered"))
			btn.pressed.connect(_on_button_pressed.bind(btn.text))
			
			container.add_child(btn)


func _setup_theme():
	if !margin_container:
		return
		
	margin_container.add_theme_constant_override("margin_top", margin_top)
	margin_container.add_theme_constant_override("margin_bottom", margin_bottom)
	margin_container.add_theme_constant_override("margin_left", margin_left)
	margin_container.add_theme_constant_override("margin_right", margin_right)
	set_anchor_for(margin_container, anchor_preset)


# Remove BoxConatiners and Buttons
func _clear_margin_container() -> void:
	for boxContainer in margin_container.get_children():
		for button in boxContainer.get_children():
			button.queue_free()
		boxContainer.queue_free()


func _get_buttons() -> Array[Node]:
	var conatiners := margin_container.get_children() as Array[Node]
	if conatiners.size() != 1:
		return []
	var box_container := conatiners[0]
	return box_container.get_children() as Array[Node]


# MNK: Remove focus on any button
func _remove_all_focus():
	var btns := _get_buttons()
	for btn in btns:
		if btn.has_focus():
			btn.release_focus()


func _on_button_focused(event_type: String):
	if (event_type == "mouse_entered" && GameInputManager.is_input_type_keyboard()) || (event_type == "focus_entered" && !GameInputManager.is_input_type_keyboard()):
		audio_stream_player.stream = focus_sound
		audio_stream_player.play()


func _on_button_pressed(button_text):
	if press_sound:
		audio_stream_player.stream = press_sound
		audio_stream_player.play()
	on_menu_button_pressed.emit(button_text)
