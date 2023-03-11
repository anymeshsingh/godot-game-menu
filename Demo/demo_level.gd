extends Node3D


var _pause_menu: PauseMenu

@onready var box = $Box


func _ready():
	animate_tween()


func _process(delta):
	box.rotate_y(0.5 * delta)


func _input(_event):
	if Input.is_action_pressed("ui_pause"):
		_toggle_pause_menu()


func animate_tween():
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(box, "position", Vector3(0, 0.3, 0), 1)
	tween.tween_property(box, "position", Vector3(0, -0.2, 0), 1)
	tween.tween_interval(0.1)

func _toggle_pause_menu():
	if !_pause_menu:
		var scene: PackedScene = preload("res://GameMenus/pause_menu.tscn")
		_pause_menu = scene.instantiate()
		add_child(_pause_menu)
	else:
		_pause_menu.queue_free()
