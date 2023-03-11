extends Node3D

@onready var box = $Box


func _ready():
	animate_tween()


func _process(delta):
	box.rotate_y(0.5 * delta)


func animate_tween():
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(box, "position", Vector3(0, 0.3, 0), 1)
	tween.tween_property(box, "position", Vector3(0, -0.2, 0), 1)
	tween.tween_interval(0.1)
