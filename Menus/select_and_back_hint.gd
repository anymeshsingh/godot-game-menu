extends SimpleGameMenu

class_name SelectAndBackHint

@export var showSelect := true
@export var showBack := true

@onready var select = $MarginContainer/HBoxContainer/Select
@onready var back = $MarginContainer/HBoxContainer/Back


func _ready():
	select.visible = showSelect
	back.visible = showBack

static func init(_select: bool = true, _back: bool = true) -> SelectAndBackHint:
	var scene: PackedScene = preload("res://Menus/select_and_back_hint.tscn")
	var instance: SelectAndBackHint = scene.instantiate()
	instance.showSelect = _select
	instance.showBack = _back
	return instance
