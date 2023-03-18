@tool
class_name TabMenu
extends MenuComponents


@export_category("TabMenu")
@export var update_ui: bool = false:
	set(value):
		update_ui = value
		_setup_tabs()
		_setup_theme()
		update_ui = false

@export_subgroup("Tabs")
@export var current_tab: int = 0:
	set(value):
		current_tab = value
		_set_current_tab(value)

@export_subgroup("Layout Config")
@export var margin_top: int = 50:
	set(value):
		margin_top = value
		_setup_theme()
@export var margin_bottom: int = 50:
	set(value):
		margin_bottom = value
		_setup_theme()
@export var margin_left: int = 50:
	set(value):
		margin_left = value
		_setup_theme()
@export var margin_right: int = 50:
	set(value):
		margin_right = value
		_setup_theme()

@onready var content_margin_container = $ContentMarginContainer
@onready var tab_bar_margin_container = $ContentMarginContainer/VBoxContainer/HBoxContainer/TabBarMarginContainer
@onready var tab_bar = $ContentMarginContainer/VBoxContainer/HBoxContainer/TabBarMarginContainer/TabBar
@onready var left_button_texture = $ContentMarginContainer/VBoxContainer/HBoxContainer/LeftButtonTexture
@onready var right_button_texture = $ContentMarginContainer/VBoxContainer/HBoxContainer/RightButtonTexture
@onready var tab_container = $ContentMarginContainer/VBoxContainer/TabContainer


func _ready():
	child_entered_tree.connect(_on_tab_added)
	child_exiting_tree.connect(_on_tab_added)
	tab_bar.tab_changed.connect(_on_tab_changed)
	_setup_tabs()


func _setup_tabs():
	_clear_tabs()
#
#	var childrens := get_children()
#	if childrens.is_empty():
#		return
#
#	childrens.remove_at(0)
#	childrens.remove_at(0)
#	for child in childrens:
#		if child is Control:
#			tab_bar.add_tab(child.name)
#
#			child.visible = false
#			var new_child = child.duplicate()
#			tab_container.add_child(new_child)


func _setup_theme():
	if !content_margin_container:
		return
	
	content_margin_container.add_theme_constant_override("margin_top", margin_top)
	content_margin_container.add_theme_constant_override("margin_bottom", margin_bottom)
	content_margin_container.add_theme_constant_override("margin_left", margin_left)
	content_margin_container.add_theme_constant_override("margin_right", margin_right)


func _set_current_tab(index: int):
	if index < 0 || index > tab_container.get_child_count() - 1:
		current_tab = 0
		return
	tab_bar.current_tab = index
	tab_container.current_tab = index


func _clear_tabs():
	if tab_bar == null || tab_container == null:
		return
	
	tab_bar.clear_tabs()
	var tabs = tab_container.get_children()
	for tab in tabs:
		tab.queue_free()


func _on_tab_added(_child):
	_setup_tabs()


func _on_tab_changed(index: int):
	tab_container.current_tab = index
