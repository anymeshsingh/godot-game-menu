extends Node
## [GameInputManager]
##
## Singleton class to handle input device changes
##
## Note: Add this script to AutoLoad in project settings as GameInputManager.


signal on_input_type_changed(input_type: InputType)

enum InputType {
	## Mouse and Keyboard
	## Defaults to this if no controller is connected
	MNK = -1,
	## XBox One, Series X and S Controller
	## If connected controler type no identified then defaluts to this.
	XBOX = 0,
	## PS4 Controller
	PS4 = 1,
	## PS5 Controller
	PS5 = 2,
	## Nintindo Switch Joy-cons
	NINTENDO_SWITCH_JOY_CONS = 3,
	## Nintindo Swtch Pro Controller
	NINTENDO_SWITCH_PRO_CONTROLLER = 4,
}

##
## Check below URL for controller names and GUIDs
## https://github.com/libsdl-org/SDL/blob/main/src/joystick/SDL_gamepad_db.h 
##
const _ps4_controller_name := "PS4 Controller"
const _ps5_controller_name := "PS5 Controller"
const _nintendo_switch_pro_controller_name := "Nintendo Switch Pro Controller"
const _nintendo_switch_joy_con_name := "Nintendo Switch Joy-Con"

var input_type: InputType = InputType.MNK
var button_textures: ControllerButtonTextures


func _ready():
	set_default_input_type()
	Input.connect("joy_connection_changed", _controller_connection_changed)


func _input(event):
	if input_type != InputType.MNK && (event is InputEventMouseButton || event is InputEventMouseMotion || event is InputEventKey):
		_controller_connection_changed(-1, false)
	elif input_type == InputType.MNK && (event is InputEventJoypadButton || event is InputEventJoypadMotion):
		set_default_input_type()


func is_input_type_keyboard():
	return input_type == InputType.MNK


func set_default_input_type():
	var controller_device_ids: Array[int] = Input.get_connected_joypads()
	if controller_device_ids.size() == 0:
		_controller_connection_changed(-1, false)
	else:
		_controller_connection_changed(controller_device_ids[0], true)


func _controller_connection_changed(device_id, connected):
	if connected:
		## Set Controller type
#		var guid := Input.get_joy_guid(device_id)
		var _name := Input.get_joy_name(device_id)
		
		if _name == _ps4_controller_name:
			# PS4
			input_type = InputType.PS4
			
		elif _name == _ps5_controller_name:
			# PS5
			input_type = InputType.PS5
			
		elif _name.contains(_nintendo_switch_joy_con_name):
			# Nintindo Switch Joy-cons
			input_type = InputType.NINTENDO_SWITCH_JOY_CONS
			
		elif _name == _nintendo_switch_pro_controller_name:
			# Nintindo Swtch Pro Controller
			input_type = InputType.NINTENDO_SWITCH_PRO_CONTROLLER
			
		else:
			# XBOX
			input_type = InputType.XBOX
			button_textures = XboxControllerButtonTextures.new()
			
	else:
		# MNK
		input_type = InputType.MNK
	
	on_input_type_changed.emit(input_type)
	print(input_type)
