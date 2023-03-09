@tool
class_name ActionButtonsHint
extends MenuComponents


@export_category("Action Buttons Hint")
@export_subgroup("Hints")
@export var content_direction: ContentDirection = ContentDirection.HORIZONTAL:
	set(value):
		content_direction = value
		_setup_hints()
@export var content_alignment: BoxContainer.AlignmentMode = BoxContainer.ALIGNMENT_BEGIN:
	set(value):
		content_alignment = value
		_setup_hints()
@export var icon_placement: IconPlacement = IconPlacement.LEFT:
	set(value):
		icon_placement = value
		_setup_hints()
@export var button_hints: Array[Dictionary] = []:
	set(value):
		button_hints = value
		_setup_hints()
@export var button_hint_separation: int = 20:
	set(value):
		button_hint_separation = value
		_setup_hints()
@export var icon_label_separation: int = 10:
	set(value):
		icon_label_separation = value
		_setup_hints()
@export var icon_tint: Color = Color.BLACK:
	set(value):
		icon_tint = value
		_setup_hints()

@export_subgroup("Layout Config")
@export var anchor_preset: ControlAnchorPreset = ControlAnchorPreset.PRESET_BOTTOM_RIGHT:
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

@onready var margin_container = $MarginContainer


func _ready():
	super._ready()
	_setup_hints()
	_setup_theme()


func _input_type_change(_input_type: GameInputManager.InputType) -> void:
	if GameInputManager.is_input_type_keyboard():
		visible = false
	else:
		visible = true


func _setup_hints():
	if !margin_container:
		return
	
	_clear_margin_container()
	
	var container: BoxContainer
	if content_direction:
		container = HBoxContainer.new()
	else:
		container = VBoxContainer.new()
	
	container.add_theme_constant_override("separation", button_hint_separation)
	
	margin_container.add_child(container)
	
	for button_hint in button_hints:
		if button_hint["text"] && button_hint["icon"] :
			var hint_conatiner := HBoxContainer.new()
			hint_conatiner.add_theme_constant_override("separation", icon_label_separation)
			hint_conatiner.alignment = content_alignment
			
			var label := Label.new()
			label.text = button_hint["text"]
			var icon := TextureRect.new()
			icon.texture = button_hint["icon"]
			icon.modulate = icon_tint
			icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
			if icon_placement: # RIGHT
				hint_conatiner.add_child(label)
				hint_conatiner.add_child(icon)
			else: # LEFT
				hint_conatiner.add_child(icon)
				hint_conatiner.add_child(label)
			container.add_child(hint_conatiner)


func _setup_theme():
	if !margin_container:
		return
		
	margin_container.add_theme_constant_override("margin_top", margin_top)
	margin_container.add_theme_constant_override("margin_bottom", margin_bottom)
	margin_container.add_theme_constant_override("margin_left", margin_left)
	margin_container.add_theme_constant_override("margin_right", margin_right)
	set_anchor_for(self, anchor_preset)
	set_anchor_for(margin_container, anchor_preset)


# Remove BoxConatiners and hints
func _clear_margin_container() -> void:
	for boxContainer in margin_container.get_children():
		for button in boxContainer.get_children():
			button.queue_free()
		boxContainer.queue_free()
