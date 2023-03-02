class_name SimpleGameMenu
extends Control
## Base class


enum MenuDirection {
	VERTICAL,
	HORIZONTAL,
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


func _ready():
	GameInputManager.on_input_type_changed.connect(_input_type_change)

## For initializing [MenuOptions] through code.
##
## Usage:
##     [codeblock]
##     var menu_options := MenuOptions.init([{ "text": "Quit" }])
##     add_child(menu_options)
##     [/codeblock]
static func init_menu_options(_buttons: Array[Dictionary], _menu_direction: MenuDirection = MenuDirection.VERTICAL) -> MenuOptions:
	var scene: PackedScene = preload("res://Menus/menu_options.tscn")
	var instance: MenuOptions = scene.instantiate()
	instance.buttons = _buttons
	instance.menu_direction = _menu_direction
	return instance


func set_anchor_for(control: Control, anchor_preset: ControlAnchorPreset):
	match anchor_preset:
		ControlAnchorPreset.PRESET_TOP_LEFT:
			control.anchor_top = 0
			control.anchor_bottom = 0
			control.anchor_left = 0
			control.anchor_right = 0
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_END

		ControlAnchorPreset.PRESET_TOP_RIGHT:
			control.anchor_top = 0
			control.anchor_bottom = 0
			control.anchor_left = 1
			control.anchor_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_BEGIN
			control.grow_vertical = Control.GROW_DIRECTION_END

		ControlAnchorPreset.PRESET_BOTTOM_LEFT:
			control.anchor_top = 1
			control.anchor_bottom = 1
			control.anchor_left = 0
			control.anchor_right = 0
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_BEGIN

		ControlAnchorPreset.PRESET_BOTTOM_RIGHT:
			control.anchor_top = 1
			control.anchor_bottom = 1
			control.anchor_left = 1
			control.anchor_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_BEGIN
			control.grow_vertical = Control.GROW_DIRECTION_BEGIN

		ControlAnchorPreset.PRESET_CENTER_LEFT:
			control.anchor_top = .5
			control.anchor_bottom = .5
			control.anchor_left = 0
			control.anchor_right = 0
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_BOTH

		ControlAnchorPreset.PRESET_CENTER_TOP:
			control.anchor_top = 0
			control.anchor_bottom = 0
			control.anchor_left = .5
			control.anchor_right = .5
			control.grow_horizontal = Control.GROW_DIRECTION_BOTH
			control.grow_vertical = Control.GROW_DIRECTION_END

		ControlAnchorPreset.PRESET_CENTER_RIGHT:
			control.anchor_top = .5
			control.anchor_bottom = .5
			control.anchor_left = 1
			control.anchor_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_BEGIN
			control.grow_vertical = Control.GROW_DIRECTION_BOTH

		ControlAnchorPreset.PRESET_CENTER_BOTTOM:
			control.anchor_top = 1
			control.anchor_bottom = 1
			control.anchor_left = .5
			control.anchor_right = .5
			control.grow_horizontal = Control.GROW_DIRECTION_BOTH
			control.grow_vertical = Control.GROW_DIRECTION_BEGIN

		ControlAnchorPreset.PRESET_CENTER:
			control.anchor_top = .5
			control.anchor_bottom = .5
			control.anchor_left = .5
			control.anchor_right = .5
			control.grow_horizontal = Control.GROW_DIRECTION_BOTH
			control.grow_vertical = Control.GROW_DIRECTION_BOTH

		ControlAnchorPreset.PRESET_LEFT_WIDE:
			control.anchor_top = 0
			control.anchor_bottom = 1
			control.anchor_left = 0
			control.anchor_right = 0
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_END

		ControlAnchorPreset.PRESET_TOP_WIDE:
			control.anchor_top = 0
			control.anchor_bottom = 0
			control.anchor_left = 0
			control.anchor_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_END

		ControlAnchorPreset.PRESET_RIGHT_WIDE:
			control.anchor_top = 0
			control.anchor_bottom = 1
			control.anchor_left = 1
			control.anchor_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_BEGIN
			control.grow_vertical = Control.GROW_DIRECTION_END

		ControlAnchorPreset.PRESET_BOTTOM_WIDE:
			control.anchor_top = 1
			control.anchor_bottom = 1
			control.anchor_left = 0
			control.anchor_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_BEGIN

		ControlAnchorPreset.PRESET_FULL_RECT:
			control.anchor_top = 0
			control.anchor_bottom = 1
			control.anchor_left = 0
			control.anchor_right = 1
			control.grow_horizontal = Control.GROW_DIRECTION_END
			control.grow_vertical = Control.GROW_DIRECTION_END


# Virtual function
func _input_type_change(_input_type: GameInputManager.InputType) -> void:
	pass
