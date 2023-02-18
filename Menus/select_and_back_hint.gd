extends Control

class_name SelectAndBackHint

@export var showSelect := true
@export var showBack := true

@onready var select = $MarginContainer/HBoxContainer/Select
@onready var back = $MarginContainer/HBoxContainer/Back


func _ready():
	select.visible = showSelect
	back.visible = showBack

static func init(select: bool = true, back: bool = true) -> SelectAndBackHint:
	var scene: PackedScene = preload("res://Menus/select_and_back_hint.tscn")
	var instance: SelectAndBackHint = scene.instantiate()
	instance.showSelect = select
	instance.showBack = back
	return instance
