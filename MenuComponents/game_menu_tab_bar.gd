@tool
class_name GameMenuTabBar
extends HBoxContainer


@export_category("Game Menu TabBar")
@export_group("Tabs")
@export var test: Array[Test]
@export var use_tab_container_tabs := false:
	set(value):
		use_tab_container_tabs = value
		_setup_tabs()
@export var tabs: Array[Dictionary] = [{"Title": "Game", "Icon": null}, {"Title": "Video", "Icon": null}, {"Title": "Audio", "Icon": null}]:
	set(value):
		tabs = _format_tabs(value)
		_setup_tabs()
@export_node_path("TabContainer") var tab_container: NodePath:
	set(value):
		tab_container = value
		_setup_tab_container()
@export var input_buttons_texture_sepeartion := 30:
	set(value):
		input_buttons_texture_sepeartion = value
		_setup_layout()

var _tab_container: TabContainer

@onready var tab_bar: TabBar = $TabBar
@onready var left_button_texture: TextureRect = $LeftButtonTexture
@onready var right_button_texture: TextureRect = $RightButtonTexture

var arr

func _ready():
	_input_type_change(GameInputManager.input_type)
	GameInputManager.on_input_type_changed.connect(_input_type_change)
	tab_bar.tab_changed.connect(_on_tab_changed)
	
	_setup_tabs()
	_setup_tab_container()
	_setup_layout()
#	if test != null && test.size():
#		test[0].print_type()


func _input(_event):
	if Input.is_action_pressed("ui_tab_left"):
		previous_tab()
	elif Input.is_action_pressed("ui_tab_right"):
		next_tab()


func _get_configuration_warnings() -> PackedStringArray:
	var warnings_array: Array[String] = []
	if tab_container == null || (tab_container != null && tab_container.is_empty()):
		warnings_array.append("Select a TabContainer")
	elif !use_tab_container_tabs:
		if tab_bar.tab_count != _tab_container.get_tab_count():
			warnings_array.append("The no. of tabs in GameMenuTabBar does not match with the no. of tabs in TabContainer.")
	if get_child_count() > 3:
		warnings_array.append("Please remove any child Nodes.")
	return PackedStringArray(warnings_array)


func _get(property):
	match property:
		"property_name":
			return arr


func _set(property, value):
	match property:
		"property_name":
			arr = value

func _get_property_list() -> Array:
	return [
		{
			name = "tab_0/title",
			type = TYPE_STRING,
			usage = PROPERTY_USAGE_DEFAULT,
			hint = PROPERTY_HINT_PLACEHOLDER_TEXT,
			hint_string = ""
		},
		{
			name = "tab_0/icon",
			type = TYPE_OBJECT,
			usage = PROPERTY_USAGE_DEFAULT,
			hint = PROPERTY_HINT_RESOURCE_TYPE,
			hint_string = "Texture2D"
		}
	]


func clear_tabs():
	tab_bar.clear_tabs()


func next_tab():
	if tab_bar.tab_count < 2:
		return
	if tab_bar.current_tab == tab_bar.tab_count - 1: # last tab
		tab_bar.current_tab = 0
	else:
		tab_bar.current_tab += 1


func previous_tab():
	if tab_bar.tab_count < 2:
		return
	if tab_bar.current_tab == 0: # first tab
		tab_bar.current_tab = tab_bar.tab_count - 1
	else:
		tab_bar.current_tab -= 1


func _format_tabs(new_tabs: Array[Dictionary]) -> Array[Dictionary]:
	for tab in new_tabs:
		if tab.is_empty():
			tab["Title"] = ""
			tab["Icon"] = null
	return new_tabs


func _setup_tabs():
	if !tab_bar:
		return
	
	clear_tabs()
	
	if use_tab_container_tabs && _tab_container != null:
		var _tabs := _tab_container.get_children()
		for _tab in _tabs:
			tab_bar.add_tab(_tab.name)
	elif !use_tab_container_tabs:
		for tab in tabs:
			if (tab.has("Title") && tab["Title"] != "") || (tab.has("Icon") && tab["Icon"] is Texture2D):
				tab_bar.add_tab(tab["Title"], tab["Icon"])


func _setup_tab_container():
	if has_node(tab_container):
		_tab_container = get_node(tab_container)
		_setup_tabs()


func _setup_layout():
	add_theme_constant_override("separation", input_buttons_texture_sepeartion)


func _on_tab_changed(index: int):
	if !tab_bar || !_tab_container:
		return
	if tab_bar.tab_count != _tab_container.get_tab_count():
		return
	_tab_container.current_tab = index


func _input_type_change(input_type: GameInputManager.InputType):
	if input_type == GameInputManager.InputType.MNK:
		left_button_texture.visible = false
		right_button_texture.visible = false
	else:
		left_button_texture.visible = true
		right_button_texture.visible = true
