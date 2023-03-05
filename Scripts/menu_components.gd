class_name MenuComponents
extends SimpleGameMenu


enum ContentDirection {
	VERTICAL,
	HORIZONTAL,
}

enum IconPlacement {
	LEFT,
	RIGHT,
}

enum ControlAnchorPreset {
	PRESET_TOP_LEFT,
	PRESET_TOP_RIGHT,
	PRESET_BOTTOM_LEFT,
	PRESET_BOTTOM_RIGHT,
	PRESET_CENTER_LEFT,
	PRESET_CENTER_TOP,
	PRESET_CENTER_RIGHT,
	PRESET_CENTER_BOTTOM,
	PRESET_CENTER,
	PRESET_LEFT_WIDE,
	PRESET_TOP_WIDE,
	PRESET_RIGHT_WIDE,
	PRESET_BOTTOM_WIDE,
	PRESET_FULL_RECT,
}


## For initializing [MenuOptions] through code.
##
## Usage:
##     [codeblock]
##     var menu_options := MenuComponents.init_menu_options([{ "text": "Quit" }])
##     add_child(menu_options)
##     [/codeblock]
static func init_menu_options(_buttons: Array[Dictionary], _menu_direction: ContentDirection = ContentDirection.VERTICAL) -> MenuOptions:
	var scene: PackedScene = preload("res://MenuComponents/menu_options.tscn")
	var instance: MenuOptions = scene.instantiate()
	instance.buttons = _buttons
	instance.menu_direction = _menu_direction
	return instance


## For initializing [ActionButtonsHint] through code.
##
## Usage:
##     [codeblock]
##     var action_buttons_hint := MenuComponents.init_action_buttons_hint([{ "text": "Select", "icon": [Texture2D] }])
##     add_child(action_buttons_hint)
##     [/codeblock]
static func init_action_buttons_hint(_button_hints: Array[Dictionary]) -> ActionButtonsHint:
	var scene: PackedScene = preload("res://MenuComponents/action_buttons_hint.tscn")
	var instance: ActionButtonsHint = scene.instantiate()
	instance.button_hints = _button_hints
	return instance


static func init_simple_dialog(_title: String, _description: String, _buttons: Array[Dictionary]) -> SimpleDialog:
	var scene: PackedScene = preload("res://MenuComponents/simple_dialog.tscn")
	var instance: SimpleDialog = scene.instantiate()
	instance.title_text = _title
	instance.title_text_label_settings = preload("res://Themes/LabelSettings/bold_label_settings.tres")
	instance.description_text = _description
	instance.buttons = _buttons
	return instance


func set_anchor_for(control: Control, anchor_preset: ControlAnchorPreset):
	match anchor_preset:
		ControlAnchorPreset.PRESET_TOP_LEFT:
			control.anchor_top = 0
			control.anchor_bottom = 0
			control.anchor_left = 0
			control.anchor_right = 0
			control.offset_top = 0
			control.offset_bottom = 0
			control.offset_left = 0
			control.offset_right = 0
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_END

		ControlAnchorPreset.PRESET_TOP_RIGHT:
			control.anchor_top = 0
			control.anchor_bottom = 0
			control.anchor_left = 1
			control.anchor_right = 1
			control.offset_top = 0
			control.offset_bottom = 0
			control.offset_left = 1
			control.offset_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_BEGIN
			control.grow_vertical = Control.GROW_DIRECTION_END

		ControlAnchorPreset.PRESET_BOTTOM_LEFT:
			control.anchor_top = 1
			control.anchor_bottom = 1
			control.anchor_left = 0
			control.anchor_right = 0
			control.offset_top = 1
			control.offset_bottom = 1
			control.offset_left = 0
			control.offset_right = 0
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_BEGIN

		ControlAnchorPreset.PRESET_BOTTOM_RIGHT:
			control.anchor_top = 1
			control.anchor_bottom = 1
			control.anchor_left = 1
			control.anchor_right = 1
			control.offset_top = 1
			control.offset_bottom = 1
			control.offset_left = 1
			control.offset_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_BEGIN
			control.grow_vertical = Control.GROW_DIRECTION_BEGIN

		ControlAnchorPreset.PRESET_CENTER_LEFT:
			control.anchor_top = 0.5
			control.anchor_bottom = 0.5
			control.anchor_left = 0
			control.anchor_right = 0
			control.offset_top = 0.5
			control.offset_bottom = 0.5
			control.offset_left = 0
			control.offset_right = 0
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_BOTH

		ControlAnchorPreset.PRESET_CENTER_TOP:
			control.anchor_top = 0
			control.anchor_bottom = 0
			control.anchor_left = 0.5
			control.anchor_right = 0.5
			control.offset_top = 0
			control.offset_bottom = 0
			control.offset_left = 0.5
			control.offset_right = 0.5
			control.grow_horizontal = Control.GROW_DIRECTION_BOTH
			control.grow_vertical = Control.GROW_DIRECTION_END

		ControlAnchorPreset.PRESET_CENTER_RIGHT:
			control.anchor_top = 0.5
			control.anchor_bottom = 0.5
			control.anchor_left = 1
			control.anchor_right = 1
			control.offset_top = 0.5
			control.offset_bottom = 0.5
			control.offset_left = 1
			control.offset_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_BEGIN
			control.grow_vertical = Control.GROW_DIRECTION_BOTH

		ControlAnchorPreset.PRESET_CENTER_BOTTOM:
			control.anchor_top = 1
			control.anchor_bottom = 1
			control.anchor_left = .5
			control.anchor_right = .5
			control.offset_top = 1
			control.offset_bottom = 1
			control.offset_left = 0.5
			control.offset_right = 0.5
			control.grow_horizontal = Control.GROW_DIRECTION_BOTH
			control.grow_vertical = Control.GROW_DIRECTION_BEGIN

		ControlAnchorPreset.PRESET_CENTER:
			control.anchor_top = 0.5
			control.anchor_bottom = 0.5
			control.anchor_left = 0.5
			control.anchor_right = 0.5
			control.offset_top = 0.5
			control.offset_bottom = 0.5
			control.offset_left = 0.5
			control.offset_right = 0.5
			control.grow_horizontal = Control.GROW_DIRECTION_BOTH
			control.grow_vertical = Control.GROW_DIRECTION_BOTH

		ControlAnchorPreset.PRESET_LEFT_WIDE:
			control.anchor_top = 0
			control.anchor_bottom = 1
			control.anchor_left = 0
			control.anchor_right = 0
			control.offset_top = 0
			control.offset_bottom = 1
			control.offset_left = 0
			control.offset_right = 0
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_END

		ControlAnchorPreset.PRESET_TOP_WIDE:
			control.anchor_top = 0
			control.anchor_bottom = 0
			control.anchor_left = 0
			control.anchor_right = 1
			control.offset_top = 0
			control.offset_bottom = 0
			control.offset_left = 0
			control.offset_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_END

		ControlAnchorPreset.PRESET_RIGHT_WIDE:
			control.anchor_top = 0
			control.anchor_bottom = 1
			control.anchor_left = 1
			control.anchor_right = 1
			control.offset_top = 0
			control.offset_bottom = 1
			control.offset_left = 1
			control.offset_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_BEGIN
			control.grow_vertical = Control.GROW_DIRECTION_END

		ControlAnchorPreset.PRESET_BOTTOM_WIDE:
			control.anchor_top = 1
			control.anchor_bottom = 1
			control.anchor_left = 0
			control.anchor_right = 1
			control.offset_top = 1
			control.offset_bottom = 1
			control.offset_left = 0
			control.offset_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_BEGIN

		ControlAnchorPreset.PRESET_FULL_RECT:
			control.anchor_top = 0
			control.anchor_bottom = 1
			control.anchor_left = 0
			control.anchor_right = 1
			control.offset_top = 0
			control.offset_bottom = 1
			control.offset_left = 0
			control.offset_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_END
