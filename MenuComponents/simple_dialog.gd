@tool
class_name SimpleDialog
extends MenuComponents


signal on_dialog_button_pressed(button_text: String)

@export_category("Simple Dialog")
@export_subgroup("Overlay")
@export var show_overlay: bool = true:
	set(value):
		show_overlay = value
		_setup_overlay()
@export var overlay_color: Color = Color.from_hsv(0, 0, 0, 0.2):
	set(value):
		overlay_color = value
		_setup_overlay()

@export_subgroup("Dialog")
@export var content_margin_top: int = 20:
	set(value):
		content_margin_top = value
		_setup_dialog()
@export var content_margin_bottom: int = 20:
	set(value):
		content_margin_bottom = value
		_setup_dialog()
@export var content_margin_left: int = 20:
	set(value):
		content_margin_left = value
		_setup_dialog()
@export var content_margin_right: int = 20:
	set(value):
		content_margin_right = value
		_setup_dialog()
@export var content_separation: int = 50:
	set(value):
		content_separation = value
		_setup_dialog()

@export_subgroup("Title")
@export var title_alignment: BoxContainer.AlignmentMode = BoxContainer.ALIGNMENT_CENTER:
	set(value):
		title_alignment = value
		_setup_dialog()
@export var title_text: String = "Title":
	set(value):
		title_text = value
		_setup_dialog()
@export var title_text_label_settings: LabelSettings:
	set(value):
		title_text_label_settings = value
		_setup_dialog()
@export var title_icon: Texture2D:
	set(value):
		title_icon = value
		_setup_dialog()
@export var title_icon_label_separation: int = 10:
	set(value):
		title_icon_label_separation = value
		_setup_dialog()
@export var title_icon_placement: IconPlacement = IconPlacement.LEFT:
	set(value):
		title_icon_placement = value
		_setup_dialog()
@export var title_icon_tint: Color = Color.BLACK:
	set(value):
		title_icon_tint = value
		_setup_dialog()
@export var title_icon_expand_mode: TextureRect.ExpandMode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL:
	set(value):
		title_icon_expand_mode = value
		_setup_dialog()

@export_subgroup("Description")
@export_multiline var description_text: String = "Description":
	set(value):
		description_text = value
		_setup_dialog()
@export var description_text_alignment: HorizontalAlignment = HORIZONTAL_ALIGNMENT_CENTER:
	set(value):
		description_text_alignment = value
		_setup_dialog()
@export var description_autowrap_mode: TextServer.AutowrapMode = TextServer.AUTOWRAP_WORD_SMART:
	set(value):
		description_autowrap_mode = value
		_setup_dialog()
@export var description_text_label_settings: LabelSettings:
	set(value):
		description_text_label_settings = value
		_setup_dialog()

@export_subgroup("Buttons")
@export var buttons_direction: ContentDirection = ContentDirection.HORIZONTAL:
	set(value):
		buttons_direction = value
		_setup_dialog()
@export var buttons: Array[Dictionary] = [{"text": "Yes", "input_map": "ui_accept" }, {"text": "No"}]:
	set(value):
		buttons = value
		_setup_dialog()
@export var button_separation: int = 10:
	set(value):
		button_separation = value
		_setup_dialog()

@export_subgroup("Layout Config")
@export var anchor_preset: ControlAnchorPreset = ControlAnchorPreset.PRESET_CENTER:
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
@export var button_focus_sound: AudioStream
@export var button_press_sound: AudioStream

var _handle_buttons_input_maps: bool = false

@onready var overlay = $Overlay
@onready var margin_container = $MarginContainer
@onready var content_margin_container = $MarginContainer/PanelContainer/ContentMarginContainer
@onready var v_box_container = $MarginContainer/PanelContainer/ContentMarginContainer/VBoxContainer
@onready var audio_stream_player = $AudioStreamPlayer


func _ready():
	super._ready()
	_setup_overlay()
	_setup_dialog()
	_setup_theme()
	
	_input_type_change(GameInputManager.input_type)


func _input(_event):
	if _handle_buttons_input_maps && !GameInputManager.is_input_type_keyboard() && buttons.size():
		for button in buttons:
			if Input.is_action_pressed(button["input_map"]):
				_on_button_pressed(button["text"])


# Override vitual function from [SimpleGameMenu]
func _input_type_change(_input_type: GameInputManager.InputType):
	if _input_type == GameInputManager.InputType.MNK:
		_remove_all_focus()
	elif !_handle_buttons_input_maps:
		_focus_first()


func _setup_overlay():
	if !overlay:
		return
	overlay.visible = show_overlay
	overlay.color = overlay_color
	if show_overlay:
		set_anchor_for(self, ControlAnchorPreset.PRESET_FULL_RECT)
		set_anchor_for(overlay, ControlAnchorPreset.PRESET_FULL_RECT)
	else:
		set_anchor_for(self, anchor_preset)


func _setup_dialog():
	if !v_box_container:
		return
	
	content_margin_container.add_theme_constant_override("margin_top", content_margin_top)
	content_margin_container.add_theme_constant_override("margin_bottom", content_margin_bottom)
	content_margin_container.add_theme_constant_override("margin_left", content_margin_left)
	content_margin_container.add_theme_constant_override("margin_right", content_margin_right)

	v_box_container.add_theme_constant_override("separation", content_separation)
	
	_clear_content_container()
	
	_setup_title()
	_setup_description()
	_setup_buttons()


func _setup_title():
	if title_icon != null || title_text != null:
		var icon: TextureRect
		var title: Label
		if title_icon:
			icon = TextureRect.new()
			icon.texture = title_icon
			icon.modulate = title_icon_tint
			icon.expand_mode = title_icon_expand_mode
		if title_text != null && title_text != "":
			title = Label.new()
			title.text = title_text
			title.label_settings = title_text_label_settings
			
		var title_container := HBoxContainer.new()
		title_container.alignment = title_alignment
		title_container.add_theme_constant_override("separation", title_icon_label_separation)
		
		if title_icon_placement: # Right
			if title:
				title_container.add_child(title)
			if icon:
				title_container.add_child(icon)
		else: # Left
			if icon:
				title_container.add_child(icon)
			if title:
				title_container.add_child(title)
		if title != null || icon != null:
			v_box_container.add_child(title_container)


func _setup_description():
	if description_text != null && description_text != "":
		var description := Label.new()
		description.text = description_text
		description.horizontal_alignment = description_text_alignment
		description.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		description.autowrap_mode = description_autowrap_mode
		description.label_settings = description_text_label_settings
		v_box_container.add_child(description)


func _setup_buttons():
	if buttons != null && buttons.size():
		var button_container: BoxContainer
		if buttons_direction:
			button_container = HBoxContainer.new()
		else:
			button_container = VBoxContainer.new()
		
		button_container.add_theme_constant_override("separation", button_separation)
		
		_handle_buttons_input_maps = true
		for button in buttons:
			if button["text"]:
				var btn := Button.new()
				btn.text = button["text"]
				btn.alignment = HORIZONTAL_ALIGNMENT_CENTER
				btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				btn.size_flags_vertical = Control.SIZE_EXPAND_FILL
				
				if !button.has("input_map"):
					_handle_buttons_input_maps = false
				elif !InputMap.has_action(button["input_map"]):
					_handle_buttons_input_maps = false
				
				if button.has("icon") && button["icon"] is Texture2D:
					btn.icon = button["icon"]
					btn.icon_alignment = HORIZONTAL_ALIGNMENT_LEFT
				
				if button.has("disabled"):
					btn.disabled = button["disabled"]
				if button_focus_sound:
					btn.focus_entered.connect(_on_button_focused.bind("focus_entered"))
					btn.mouse_entered.connect(_on_button_focused.bind("mouse_entered"))
				btn.pressed.connect(_on_button_pressed.bind(btn.text))
				button_container.add_child(btn)
		
		v_box_container.add_child(button_container)


func _setup_theme():
	if !margin_container:
		return
		
	margin_container.add_theme_constant_override("margin_top", margin_top)
	margin_container.add_theme_constant_override("margin_bottom", margin_bottom)
	margin_container.add_theme_constant_override("margin_left", margin_left)
	margin_container.add_theme_constant_override("margin_right", margin_right)
	
	if !show_overlay:
		set_anchor_for(self, anchor_preset)
	set_anchor_for(margin_container, anchor_preset)


func _clear_content_container() -> void:
	for content in v_box_container.get_children():
		content.queue_free()


func _get_buttons() -> Array[Node]:
	var conatiners := v_box_container.get_children() as Array[Node]
	for conatiner in conatiners:
		if conatiner is HBoxContainer:
			for btn in conatiner.get_children():
				if btn is Button:
					return conatiner.get_children()
	
	return []


func _focus_first():
	var btns := _get_buttons()
	if btns.size():
		btns[0].grab_focus()


func _remove_all_focus():
	var btns := _get_buttons()
	for btn in btns:
		if btn.has_focus():
			btn.release_focus()


func _on_button_focused(event_type: String):
	if (event_type == "mouse_entered" && GameInputManager.is_input_type_keyboard()) || (event_type == "focus_entered" && !GameInputManager.is_input_type_keyboard()):
		audio_stream_player.stream = button_focus_sound
		audio_stream_player.play()


func _on_button_pressed(button_text: String):
	if button_press_sound:
		audio_stream_player.stream = button_press_sound
		audio_stream_player.play()
	on_dialog_button_pressed.emit(button_text)
